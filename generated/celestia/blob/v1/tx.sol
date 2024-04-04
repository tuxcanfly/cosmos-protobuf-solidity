// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.9;
import "../../../ProtoBufRuntime.sol";
import "../../../GoogleProtobufAny.sol";

library CelestiaBlobV1MsgPayForBlobs {
    //struct definition
    struct Data {
        string signer;
        bytes[] namespaces;
        uint32[] blob_sizes;
        bytes[] share_commitments;
        uint32[] share_versions;
    }

    // Decoder section

    /**
     * @dev The main decoder for memory
     * @param bs The bytes array to be decoded
     * @return The decoded struct
     */
    function decode(bytes memory bs) internal pure returns (Data memory) {
        (Data memory x, ) = _decode(32, bs, bs.length);
        return x;
    }

    /**
     * @dev The main decoder for storage
     * @param self The in-storage struct
     * @param bs The bytes array to be decoded
     */
    function decode(Data storage self, bytes memory bs) internal {
        (Data memory x, ) = _decode(32, bs, bs.length);
        store(x, self);
    }

    // inner decoder

    /**
     * @dev The decoder for internal usage
     * @param p The offset of bytes array to start decode
     * @param bs The bytes array to be decoded
     * @param sz The number of bytes expected
     * @return The decoded struct
     * @return The number of bytes decoded
     */
    function _decode(
        uint256 p,
        bytes memory bs,
        uint256 sz
    ) internal pure returns (Data memory, uint) {
        Data memory r;
        uint[9] memory counters;
        uint256 fieldId;
        ProtoBufRuntime.WireType wireType;
        uint256 bytesRead;
        uint256 offset = p;
        uint256 pointer = p;
        while (pointer < offset + sz) {
            (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(
                pointer,
                bs
            );
            pointer += bytesRead;
            if (fieldId == 1) {
                pointer += _read_signer(pointer, bs, r);
            } else if (fieldId == 2) {
                pointer += _read_unpacked_repeated_namespaces(
                    pointer,
                    bs,
                    nil(),
                    counters
                );
            } else if (fieldId == 3) {
                if (wireType == ProtoBufRuntime.WireType.LengthDelim) {
                    pointer += _read_packed_repeated_blob_sizes(pointer, bs, r);
                } else {
                    pointer += _read_unpacked_repeated_blob_sizes(
                        pointer,
                        bs,
                        nil(),
                        counters
                    );
                }
            } else if (fieldId == 4) {
                pointer += _read_unpacked_repeated_share_commitments(
                    pointer,
                    bs,
                    nil(),
                    counters
                );
            } else if (fieldId == 8) {
                if (wireType == ProtoBufRuntime.WireType.LengthDelim) {
                    pointer += _read_packed_repeated_share_versions(
                        pointer,
                        bs,
                        r
                    );
                } else {
                    pointer += _read_unpacked_repeated_share_versions(
                        pointer,
                        bs,
                        nil(),
                        counters
                    );
                }
            } else {
                pointer += ProtoBufRuntime._skip_field_decode(
                    wireType,
                    pointer,
                    bs
                );
            }
        }
        pointer = offset;
        if (counters[2] > 0) {
            require(r.namespaces.length == 0);
            r.namespaces = new bytes[](counters[2]);
        }
        if (counters[3] > 0) {
            require(r.blob_sizes.length == 0);
            r.blob_sizes = new uint32[](counters[3]);
        }
        if (counters[4] > 0) {
            require(r.share_commitments.length == 0);
            r.share_commitments = new bytes[](counters[4]);
        }
        if (counters[8] > 0) {
            require(r.share_versions.length == 0);
            r.share_versions = new uint32[](counters[8]);
        }

        while (pointer < offset + sz) {
            (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(
                pointer,
                bs
            );
            pointer += bytesRead;
            if (fieldId == 2) {
                pointer += _read_unpacked_repeated_namespaces(
                    pointer,
                    bs,
                    r,
                    counters
                );
            } else if (
                fieldId == 3 && wireType != ProtoBufRuntime.WireType.LengthDelim
            ) {
                pointer += _read_unpacked_repeated_blob_sizes(
                    pointer,
                    bs,
                    r,
                    counters
                );
            } else if (fieldId == 4) {
                pointer += _read_unpacked_repeated_share_commitments(
                    pointer,
                    bs,
                    r,
                    counters
                );
            } else if (
                fieldId == 8 && wireType != ProtoBufRuntime.WireType.LengthDelim
            ) {
                pointer += _read_unpacked_repeated_share_versions(
                    pointer,
                    bs,
                    r,
                    counters
                );
            } else {
                pointer += ProtoBufRuntime._skip_field_decode(
                    wireType,
                    pointer,
                    bs
                );
            }
        }
        return (r, sz);
    }

    // field readers

    /**
     * @dev The decoder for reading a field
     * @param p The offset of bytes array to start decode
     * @param bs The bytes array to be decoded
     * @param r The in-memory struct
     * @return The number of bytes decoded
     */
    function _read_signer(
        uint256 p,
        bytes memory bs,
        Data memory r
    ) internal pure returns (uint) {
        (string memory x, uint256 sz) = ProtoBufRuntime._decode_string(p, bs);
        r.signer = x;
        return sz;
    }

    /**
     * @dev The decoder for reading a field
     * @param p The offset of bytes array to start decode
     * @param bs The bytes array to be decoded
     * @param r The in-memory struct
     * @param counters The counters for repeated fields
     * @return The number of bytes decoded
     */
    function _read_unpacked_repeated_namespaces(
        uint256 p,
        bytes memory bs,
        Data memory r,
        uint[9] memory counters
    ) internal pure returns (uint) {
        /**
         * if `r` is NULL, then only counting the number of fields.
         */
        (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
        if (isNil(r)) {
            counters[2] += 1;
        } else {
            r.namespaces[r.namespaces.length - counters[2]] = x;
            counters[2] -= 1;
        }
        return sz;
    }

    /**
     * @dev The decoder for reading a field
     * @param p The offset of bytes array to start decode
     * @param bs The bytes array to be decoded
     * @param r The in-memory struct
     * @param counters The counters for repeated fields
     * @return The number of bytes decoded
     */
    function _read_unpacked_repeated_blob_sizes(
        uint256 p,
        bytes memory bs,
        Data memory r,
        uint[9] memory counters
    ) internal pure returns (uint) {
        /**
         * if `r` is NULL, then only counting the number of fields.
         */
        (uint32 x, uint256 sz) = ProtoBufRuntime._decode_uint32(p, bs);
        if (isNil(r)) {
            counters[3] += 1;
        } else {
            r.blob_sizes[r.blob_sizes.length - counters[3]] = x;
            counters[3] -= 1;
        }
        return sz;
    }

    /**
     * @dev The decoder for reading a field
     * @param p The offset of bytes array to start decode
     * @param bs The bytes array to be decoded
     * @param r The in-memory struct
     * @return The number of bytes decoded
     */
    function _read_packed_repeated_blob_sizes(
        uint256 p,
        bytes memory bs,
        Data memory r
    ) internal pure returns (uint) {
        (uint256 len, uint256 size) = ProtoBufRuntime._decode_varint(p, bs);
        p += size;
        uint256 count = ProtoBufRuntime._count_packed_repeated_varint(
            p,
            len,
            bs
        );
        r.blob_sizes = new uint32[](count);
        for (uint256 i = 0; i < count; i++) {
            (uint32 x, uint256 sz) = ProtoBufRuntime._decode_uint32(p, bs);
            p += sz;
            r.blob_sizes[i] = x;
        }
        return size + len;
    }

    /**
     * @dev The decoder for reading a field
     * @param p The offset of bytes array to start decode
     * @param bs The bytes array to be decoded
     * @param r The in-memory struct
     * @param counters The counters for repeated fields
     * @return The number of bytes decoded
     */
    function _read_unpacked_repeated_share_commitments(
        uint256 p,
        bytes memory bs,
        Data memory r,
        uint[9] memory counters
    ) internal pure returns (uint) {
        /**
         * if `r` is NULL, then only counting the number of fields.
         */
        (bytes memory x, uint256 sz) = ProtoBufRuntime._decode_bytes(p, bs);
        if (isNil(r)) {
            counters[4] += 1;
        } else {
            r.share_commitments[r.share_commitments.length - counters[4]] = x;
            counters[4] -= 1;
        }
        return sz;
    }

    /**
     * @dev The decoder for reading a field
     * @param p The offset of bytes array to start decode
     * @param bs The bytes array to be decoded
     * @param r The in-memory struct
     * @param counters The counters for repeated fields
     * @return The number of bytes decoded
     */
    function _read_unpacked_repeated_share_versions(
        uint256 p,
        bytes memory bs,
        Data memory r,
        uint[9] memory counters
    ) internal pure returns (uint) {
        /**
         * if `r` is NULL, then only counting the number of fields.
         */
        (uint32 x, uint256 sz) = ProtoBufRuntime._decode_uint32(p, bs);
        if (isNil(r)) {
            counters[8] += 1;
        } else {
            r.share_versions[r.share_versions.length - counters[8]] = x;
            counters[8] -= 1;
        }
        return sz;
    }

    /**
     * @dev The decoder for reading a field
     * @param p The offset of bytes array to start decode
     * @param bs The bytes array to be decoded
     * @param r The in-memory struct
     * @return The number of bytes decoded
     */
    function _read_packed_repeated_share_versions(
        uint256 p,
        bytes memory bs,
        Data memory r
    ) internal pure returns (uint) {
        (uint256 len, uint256 size) = ProtoBufRuntime._decode_varint(p, bs);
        p += size;
        uint256 count = ProtoBufRuntime._count_packed_repeated_varint(
            p,
            len,
            bs
        );
        r.share_versions = new uint32[](count);
        for (uint256 i = 0; i < count; i++) {
            (uint32 x, uint256 sz) = ProtoBufRuntime._decode_uint32(p, bs);
            p += sz;
            r.share_versions[i] = x;
        }
        return size + len;
    }

    // Encoder section

    /**
     * @dev The main encoder for memory
     * @param r The struct to be encoded
     * @return The encoded byte array
     */
    function encode(Data memory r) internal pure returns (bytes memory) {
        bytes memory bs = new bytes(_estimate(r));
        uint256 sz = _encode(r, 32, bs);
        assembly {
            mstore(bs, sz)
        }
        return bs;
    }

    // inner encoder

    /**
     * @dev The encoder for internal usage
     * @param r The struct to be encoded
     * @param p The offset of bytes array to start decode
     * @param bs The bytes array to be decoded
     * @return The number of bytes encoded
     */
    function _encode(
        Data memory r,
        uint256 p,
        bytes memory bs
    ) internal pure returns (uint) {
        uint256 offset = p;
        uint256 pointer = p;
        uint256 i;
        if (bytes(r.signer).length != 0) {
            pointer += ProtoBufRuntime._encode_key(
                1,
                ProtoBufRuntime.WireType.LengthDelim,
                pointer,
                bs
            );
            pointer += ProtoBufRuntime._encode_string(r.signer, pointer, bs);
        }
        if (r.namespaces.length != 0) {
            for (i = 0; i < r.namespaces.length; i++) {
                pointer += ProtoBufRuntime._encode_key(
                    2,
                    ProtoBufRuntime.WireType.LengthDelim,
                    pointer,
                    bs
                );
                pointer += ProtoBufRuntime._encode_bytes(
                    r.namespaces[i],
                    pointer,
                    bs
                );
            }
        }
        if (r.blob_sizes.length != 0) {
            pointer += ProtoBufRuntime._encode_key(
                3,
                ProtoBufRuntime.WireType.LengthDelim,
                pointer,
                bs
            );
            pointer += ProtoBufRuntime._encode_varint(
                ProtoBufRuntime._estimate_packed_repeated_uint32(r.blob_sizes),
                pointer,
                bs
            );
            for (i = 0; i < r.blob_sizes.length; i++) {
                pointer += ProtoBufRuntime._encode_uint32(
                    r.blob_sizes[i],
                    pointer,
                    bs
                );
            }
        }
        if (r.share_commitments.length != 0) {
            for (i = 0; i < r.share_commitments.length; i++) {
                pointer += ProtoBufRuntime._encode_key(
                    4,
                    ProtoBufRuntime.WireType.LengthDelim,
                    pointer,
                    bs
                );
                pointer += ProtoBufRuntime._encode_bytes(
                    r.share_commitments[i],
                    pointer,
                    bs
                );
            }
        }
        if (r.share_versions.length != 0) {
            pointer += ProtoBufRuntime._encode_key(
                8,
                ProtoBufRuntime.WireType.LengthDelim,
                pointer,
                bs
            );
            pointer += ProtoBufRuntime._encode_varint(
                ProtoBufRuntime._estimate_packed_repeated_uint32(
                    r.share_versions
                ),
                pointer,
                bs
            );
            for (i = 0; i < r.share_versions.length; i++) {
                pointer += ProtoBufRuntime._encode_uint32(
                    r.share_versions[i],
                    pointer,
                    bs
                );
            }
        }
        return pointer - offset;
    }

    // nested encoder

    /**
     * @dev The encoder for inner struct
     * @param r The struct to be encoded
     * @param p The offset of bytes array to start decode
     * @param bs The bytes array to be decoded
     * @return The number of bytes encoded
     */
    function _encode_nested(
        Data memory r,
        uint256 p,
        bytes memory bs
    ) internal pure returns (uint) {
        /**
         * First encoded `r` into a temporary array, and encode the actual size used.
         * Then copy the temporary array into `bs`.
         */
        uint256 offset = p;
        uint256 pointer = p;
        bytes memory tmp = new bytes(_estimate(r));
        uint256 tmpAddr = ProtoBufRuntime.getMemoryAddress(tmp);
        uint256 bsAddr = ProtoBufRuntime.getMemoryAddress(bs);
        uint256 size = _encode(r, 32, tmp);
        pointer += ProtoBufRuntime._encode_varint(size, pointer, bs);
        ProtoBufRuntime.copyBytes(tmpAddr + 32, bsAddr + pointer, size);
        pointer += size;
        delete tmp;
        return pointer - offset;
    }

    // estimator

    /**
     * @dev The estimator for a struct
     * @param r The struct to be encoded
     * @return The number of bytes encoded in estimation
     */
    function _estimate(Data memory r) internal pure returns (uint) {
        uint256 e;
        uint256 i;
        e += 1 + ProtoBufRuntime._sz_lendelim(bytes(r.signer).length);
        for (i = 0; i < r.namespaces.length; i++) {
            e += 1 + ProtoBufRuntime._sz_lendelim(r.namespaces[i].length);
        }
        e +=
            1 +
            ProtoBufRuntime._sz_lendelim(
                ProtoBufRuntime._estimate_packed_repeated_uint32(r.blob_sizes)
            );
        for (i = 0; i < r.share_commitments.length; i++) {
            e +=
                1 +
                ProtoBufRuntime._sz_lendelim(r.share_commitments[i].length);
        }
        e +=
            1 +
            ProtoBufRuntime._sz_lendelim(
                ProtoBufRuntime._estimate_packed_repeated_uint32(
                    r.share_versions
                )
            );
        return e;
    }

    // empty checker

    function _empty(Data memory r) internal pure returns (bool) {
        if (bytes(r.signer).length != 0) {
            return false;
        }

        if (r.namespaces.length != 0) {
            return false;
        }

        if (r.blob_sizes.length != 0) {
            return false;
        }

        if (r.share_commitments.length != 0) {
            return false;
        }

        if (r.share_versions.length != 0) {
            return false;
        }

        return true;
    }

    //store function
    /**
     * @dev Store in-memory struct to storage
     * @param input The in-memory struct
     * @param output The in-storage struct
     */
    function store(Data memory input, Data storage output) internal {
        output.signer = input.signer;
        output.namespaces = input.namespaces;
        output.blob_sizes = input.blob_sizes;
        output.share_commitments = input.share_commitments;
        output.share_versions = input.share_versions;
    }

    //array helpers for Namespaces
    /**
     * @dev Add value to an array
     * @param self The in-memory struct
     * @param value The value to add
     */
    function addNamespaces(Data memory self, bytes memory value) internal pure {
        /**
         * First resize the array. Then add the new element to the end.
         */
        bytes[] memory tmp = new bytes[](self.namespaces.length + 1);
        for (uint256 i = 0; i < self.namespaces.length; i++) {
            tmp[i] = self.namespaces[i];
        }
        tmp[self.namespaces.length] = value;
        self.namespaces = tmp;
    }

    //array helpers for BlobSizes
    /**
     * @dev Add value to an array
     * @param self The in-memory struct
     * @param value The value to add
     */
    function addBlobSizes(Data memory self, uint32 value) internal pure {
        /**
         * First resize the array. Then add the new element to the end.
         */
        uint32[] memory tmp = new uint32[](self.blob_sizes.length + 1);
        for (uint256 i = 0; i < self.blob_sizes.length; i++) {
            tmp[i] = self.blob_sizes[i];
        }
        tmp[self.blob_sizes.length] = value;
        self.blob_sizes = tmp;
    }

    //array helpers for ShareCommitments
    /**
     * @dev Add value to an array
     * @param self The in-memory struct
     * @param value The value to add
     */
    function addShareCommitments(
        Data memory self,
        bytes memory value
    ) internal pure {
        /**
         * First resize the array. Then add the new element to the end.
         */
        bytes[] memory tmp = new bytes[](self.share_commitments.length + 1);
        for (uint256 i = 0; i < self.share_commitments.length; i++) {
            tmp[i] = self.share_commitments[i];
        }
        tmp[self.share_commitments.length] = value;
        self.share_commitments = tmp;
    }

    //array helpers for ShareVersions
    /**
     * @dev Add value to an array
     * @param self The in-memory struct
     * @param value The value to add
     */
    function addShareVersions(Data memory self, uint32 value) internal pure {
        /**
         * First resize the array. Then add the new element to the end.
         */
        uint32[] memory tmp = new uint32[](self.share_versions.length + 1);
        for (uint256 i = 0; i < self.share_versions.length; i++) {
            tmp[i] = self.share_versions[i];
        }
        tmp[self.share_versions.length] = value;
        self.share_versions = tmp;
    }

    //utility functions
    /**
     * @dev Return an empty struct
     * @return r The empty struct
     */
    function nil() internal pure returns (Data memory r) {
        assembly {
            r := 0
        }
    }

    /**
     * @dev Test whether a struct is empty
     * @param x The struct to be tested
     * @return r True if it is empty
     */
    function isNil(Data memory x) internal pure returns (bool r) {
        assembly {
            r := iszero(x)
        }
    }
}

//library CelestiaBlobV1MsgPayForBlobs

library CelestiaBlobV1MsgPayForBlobsResponse {
    //struct definition
    struct Data {
        bool x;
    }

    // Decoder section

    /**
     * @dev The main decoder for memory
     * @param bs The bytes array to be decoded
     * @return The decoded struct
     */
    function decode(bytes memory bs) internal pure returns (Data memory) {
        (Data memory x, ) = _decode(32, bs, bs.length);
        return x;
    }

    /**
     * @dev The main decoder for storage
     * @param self The in-storage struct
     * @param bs The bytes array to be decoded
     */
    function decode(Data storage self, bytes memory bs) internal {
        (Data memory x, ) = _decode(32, bs, bs.length);
        store(x, self);
    }

    // inner decoder

    /**
     * @dev The decoder for internal usage
     * @param p The offset of bytes array to start decode
     * @param bs The bytes array to be decoded
     * @param sz The number of bytes expected
     * @return The decoded struct
     * @return The number of bytes decoded
     */
    function _decode(
        uint256 p,
        bytes memory bs,
        uint256 sz
    ) internal pure returns (Data memory, uint) {
        Data memory r;
        uint256 fieldId;
        ProtoBufRuntime.WireType wireType;
        uint256 bytesRead;
        uint256 offset = p;
        uint256 pointer = p;
        while (pointer < offset + sz) {
            (fieldId, wireType, bytesRead) = ProtoBufRuntime._decode_key(
                pointer,
                bs
            );
            pointer += bytesRead;
        }
        return (r, sz);
    }

    // field readers

    // Encoder section

    /**
     * @dev The main encoder for memory
     * @param r The struct to be encoded
     * @return The encoded byte array
     */
    function encode(Data memory r) internal pure returns (bytes memory) {
        bytes memory bs = new bytes(_estimate(r));
        uint256 sz = _encode(r, 32, bs);
        assembly {
            mstore(bs, sz)
        }
        return bs;
    }

    // inner encoder

    /**
     * @dev The encoder for internal usage
     * @param r The struct to be encoded
     * @param p The offset of bytes array to start decode
     * @param bs The bytes array to be decoded
     * @return The number of bytes encoded
     */
    function _encode(
        Data memory r,
        uint256 p,
        bytes memory bs
    ) internal pure returns (uint) {
        uint256 offset = p;
        uint256 pointer = p;

        return pointer - offset;
    }

    // nested encoder

    /**
     * @dev The encoder for inner struct
     * @param r The struct to be encoded
     * @param p The offset of bytes array to start decode
     * @param bs The bytes array to be decoded
     * @return The number of bytes encoded
     */
    function _encode_nested(
        Data memory r,
        uint256 p,
        bytes memory bs
    ) internal pure returns (uint) {
        /**
         * First encoded `r` into a temporary array, and encode the actual size used.
         * Then copy the temporary array into `bs`.
         */
        uint256 offset = p;
        uint256 pointer = p;
        bytes memory tmp = new bytes(_estimate(r));
        uint256 tmpAddr = ProtoBufRuntime.getMemoryAddress(tmp);
        uint256 bsAddr = ProtoBufRuntime.getMemoryAddress(bs);
        uint256 size = _encode(r, 32, tmp);
        pointer += ProtoBufRuntime._encode_varint(size, pointer, bs);
        ProtoBufRuntime.copyBytes(tmpAddr + 32, bsAddr + pointer, size);
        pointer += size;
        delete tmp;
        return pointer - offset;
    }

    // estimator

    /**
     * @dev The estimator for a struct
     * @return The number of bytes encoded in estimation
     */
    function _estimate(Data memory /* r */) internal pure returns (uint) {
        uint256 e;
        return e;
    }

    // empty checker

    function _empty(Data memory r) internal pure returns (bool) {
        return true;
    }

    //store function
    /**
     * @dev Store in-memory struct to storage
     * @param input The in-memory struct
     * @param output The in-storage struct
     */
    function store(Data memory input, Data storage output) internal {}

    //utility functions
    /**
     * @dev Return an empty struct
     * @return r The empty struct
     */
    function nil() internal pure returns (Data memory r) {
        assembly {
            r := 0
        }
    }

    /**
     * @dev Test whether a struct is empty
     * @param x The struct to be tested
     * @return r True if it is empty
     */
    function isNil(Data memory x) internal pure returns (bool r) {
        assembly {
            r := iszero(x)
        }
    }
}
//library CelestiaBlobV1MsgPayForBlobsResponse

