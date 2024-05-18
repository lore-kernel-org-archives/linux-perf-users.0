Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A029A2
	for <linux-perf-users@vger.kernel.org>; Sat, 18 May 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716051204; cv=none; b=SBhHyNDdl+3MJovkR/ueLO9W5HddX0PVgl0zcAtC/5gkehdD5h0+CmCHuki6CFojjSTKAIU6gO6EZNNxW+J6pzNHbi0NA6CdRHG83kuke/d/m1qBCQ0H8HFyk9i/qk8sM6iezF4Iq2H6v2823D4orpWGStUO6YA63qk1SyKJPF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716051204; c=relaxed/simple;
	bh=hfF4/ADedd/JfOCz6I73Q4BjKZIvLx7Vqraeq+tPYU4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TyI3zPMBsNxhnVAQPC3DfVTVUmcyzFjyU46dxmGk3/Exx8FrVREoBn/Ar+tYFi2H+GS1WbGQ5x3qOw/kGNG3yIrS7WBwF/K47JNpXflRedQW0IEyNYm0mzSHg9VBm7j85/YY8TqQWhkz88bm1VtQ/6jzibJOV1D20phdGxVzyz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PEjAveFX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PEjAveFX"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61bea0c36bbso204401797b3.2
        for <linux-perf-users@vger.kernel.org>; Sat, 18 May 2024 09:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716051201; x=1716656001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y12G3706vB2C3fRBj2WW8vvTZtmZUq1w+NsO+AWMbSw=;
        b=PEjAveFX7mK4TP2csGwPb4VqhcEB9ggSSdv1CFxomlsD0NFpL77OtglcCyJ7Pk4/bv
         nkHKk6rlY5tvkDGjn2IFx/M31EEv6bx28b/uO97Spw2iFkcvRndXxPOB7N7uy1T2QZLV
         e8a2pVdwaIP/q8z6rFReYF5kbNN5eYiTHIkxOJlM6XZqoUnThV19Ao+hDktorMfkItwd
         okI1UlWSAxRlatXbJ36wFOkDv++Ny1pHf0d3dM/iK9F698zUafTF+T0AbfFIJaxzagYC
         siZK3fSADb0zpUcqM9M/aC51RltqyxNN3hn+KoxzOFhY0b4vmrINROk6iTEkx1KYqFiW
         tVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716051201; x=1716656001;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y12G3706vB2C3fRBj2WW8vvTZtmZUq1w+NsO+AWMbSw=;
        b=aklSZFztRoEOG6V/GWK5ZGM+79dLYToiIs2xkqqz8psyouyNAGbo0ExiEqcZ7hNfQU
         DwN4vBsUNYk4/H1S3gKMOT/+sqZlWMghF/guJjF5JEP4psFF15Q/UIAHrHV4ZDNEZkXQ
         xo4Vd68NRS7voPQEW/OHOccamsYnDVYMW/RAqZ6zyJ49fs09IO5OQrLutbuH82E402ZI
         HhM68gRrNRRv4IxmCrZXCx+1KKjLyEd2vgVFs0lH8JZ+mNpQ4nWfTWvW0BRiSRPc8vit
         goKFOJnsH3lMgl9OoVqC/7YroyiCe2Uhkm6ERwUSYmQrDLPoL6+dUvJ1gkdaYaVyFwYO
         TLKA==
X-Gm-Message-State: AOJu0Ywb6A9Mb95/Jv3xmPGckEz582B5jvERuWr6xoPlVlk/zXoBRPXD
	fZA/CMRnl3JMGf6R2nwQGxaNZxGk8GXQrtg5PwXR7VOLun1fGwih5SRQmF6BjO0r2CmnOO19pw=
	=
X-Google-Smtp-Source: AGHT+IEipU8Sq0PVoRlqOvHL4xUaWBvqo4u0Idjp6DNCo+otz2bSwqdooSqUmOW6OLM1COpdzPoC7ezeFg==
X-Received: from sesse.osl.corp.google.com ([2a00:79e0:18:10:8b68:8208:4316:d53b])
 (user=sesse job=sendgmr) by 2002:a05:690c:6302:b0:61b:46e:62da with SMTP id
 00721157ae682-622affc63bfmr64483907b3.4.1716051201181; Sat, 18 May 2024
 09:53:21 -0700 (PDT)
Date: Sat, 18 May 2024 18:53:11 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240518165315.3963142-1-sesse@google.com>
Subject: [PATCH v2] Add a trie to map quickly from address range to
 compilation unit.
From: "Steinar H. Gunderson" <sesse@google.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	irogers@google.com, "Steinar H. Gunderson" <sesse@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When using perf to profile large binaries, _bfd_dwarf2_find_nearest_line()
becomes a hotspot, as perf wants to get line number information
(for inline-detection purposes) for each and every sample. In Chromium
in particular (the content_shell binary), this entails going through
475k address ranges, which takes a long time when done repeatedly.

Add a radix-256 trie over the address space to quickly map address to
compilation unit spaces; for content_shell, which is 1.6 GB when some
(but not full) debug information turned is on, we go from 6 ms to
0.006 ms (6 =C2=B5s) for each lookup from address to compilation unit, a 10=
00x
speedup.

There is a modest RAM increase of 180 MB in this binary (the existing
linked list over ranges uses about 10 MB, and the entire perf job uses
between 2=E2=80=933 GB for a medium-size profile); for smaller binaries wit=
h few
ranges, there should be hardly any extra RAM usage at all.
---
 bfd/dwarf2.c | 372 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 354 insertions(+), 18 deletions(-)

diff --git a/bfd/dwarf2.c b/bfd/dwarf2.c
index 404f35df62b..61ca68d4e97 100644
--- a/bfd/dwarf2.c
+++ b/bfd/dwarf2.c
@@ -82,6 +82,76 @@ struct adjusted_section
   bfd_vma adj_vma;
 };
=20
+/* A trie to map quickly from address range to compilation unit.
+
+   This is a fairly standard radix-256 trie, used to quickly locate which
+   compilation unit any given address belongs to.  Given that each compila=
tion
+   unit may register hundreds of very small and unaligned ranges (which ma=
y
+   potentially overlap, due to inlining and other concerns), and a large
+   program may end up containing hundreds of thousands of such ranges, we =
cannot
+   scan through them linearly without undue slowdown.
+
+   We use a hybrid trie to avoid memory explosion: There are two types of =
trie
+   nodes, leaves and interior nodes.  (Almost all nodes are leaves, so the=
y
+   take up the bulk of the memory usage.) Leaves contain a simple array of
+   ranges (high/low address) and which compilation unit contains those ran=
ges,
+   and when we get to a leaf, we scan through it linearly.  Interior nodes
+   contain pointers to 256 other nodes, keyed by the next byte of the addr=
ess.
+   So for a 64-bit address like 0x1234567abcd, we would start at the root =
and go
+   down child[0x00]->child[0x00]->child[0x01]->child[0x23]->child[0x45] et=
c.,
+   until we hit a leaf.  (Nodes are, in general, leaves until they exceed =
the
+   default allocation of 16 elements, at which point they are converted to
+   interior node if possible.) This gives us near-constant lookup times;
+   the only thing that can be costly is if there are lots of overlapping r=
anges
+   within a single 256-byte segment of the binary, in which case we have t=
o
+   scan through them all to find the best match.
+
+   For a binary with few ranges, we will in practice only have a single le=
af node
+   at the root, containing a simple array.  Thus, the scheme is efficient =
for
+   both small and large binaries.
+ */
+
+/* Experiments have shown 16 to be a memory-efficient default leaf size.
+   The only case where a leaf will hold more memory than this, is at the
+   bottomost level (covering 256 bytes in the binary), where we'll expand
+   the leaf to be able to hold more ranges if needed.
+ */
+#define TRIE_LEAF_SIZE 16
+
+/* All trie_node pointers will really be trie_leaf or trie_interior,
+   but they have this common head.  */
+struct trie_node
+{
+  /* If zero, we are an interior node.
+     Otherwise, how many ranges we have room for in this leaf.  */
+  int num_room_in_leaf;
+};
+
+struct trie_leaf
+{
+  struct trie_node head;
+  int num_stored_in_leaf;
+  struct {
+    const struct comp_unit *unit;
+    bfd_vma low_pc, high_pc;
+  } ranges[TRIE_LEAF_SIZE];
+};
+
+struct trie_interior
+{
+  struct trie_node head;
+  struct trie_node *children[256];
+};
+
+static struct trie_node *alloc_trie_leaf (bfd *abfd)
+{
+  struct trie_leaf *leaf =3D
+    (struct trie_leaf *) bfd_zalloc (abfd, sizeof (struct trie_leaf));
+  if (leaf !=3D NULL)
+    leaf->head.num_room_in_leaf =3D TRIE_LEAF_SIZE;
+  return (struct trie_node *) leaf;
+}
+
 struct dwarf2_debug_file
 {
   /* The actual bfd from which debug info was loaded.  Might be
@@ -139,6 +209,9 @@ struct dwarf2_debug_file
   /* A list of all previously read comp_units.  */
   struct comp_unit *all_comp_units;
=20
+  /* A list of all previously read comp_units with no ranges (yet).  */
+  struct comp_unit *all_comp_units_without_ranges;
+
   /* Last comp unit in list above.  */
   struct comp_unit *last_comp_unit;
=20
@@ -147,6 +220,9 @@ struct dwarf2_debug_file
=20
   /* Hash table to map offsets to decoded abbrevs.  */
   htab_t abbrev_offsets;
+
+  /* Root of a trie to map addresses to compilation units.  */
+  struct trie_node *trie_root;
 };
=20
 struct dwarf2_debug
@@ -220,6 +296,11 @@ struct comp_unit
   /* Chain the previously read compilation units.  */
   struct comp_unit *next_unit;
=20
+  /* Chain the previously read compilation units that have no ranges yet.
+     We scan these separately when we have a trie over the ranges.
+     Unused if arange.high !=3D 0. */
+  struct comp_unit *next_unit_without_ranges;
+
   /* Likewise, chain the compilation unit read after this one.
      The comp units are stored in reversed reading order.  */
   struct comp_unit *prev_unit;
@@ -296,6 +377,10 @@ struct comp_unit
=20
   /* TRUE if symbols are cached in hash table for faster lookup by name.  =
*/
   bool cached;
+
+  /* Used when iterating over trie leaves to know which units we have
+     already seen in this iteration.  */
+  bool mark;
 };
=20
 /* This data structure holds the information of an abbrev.  */
@@ -1767,9 +1852,183 @@ concat_filename (struct line_info_table *table, uns=
igned int file)
   return strdup (filename);
 }
=20
+/* Number of bits in a bfd_vma.  */
+#define VMA_BITS (8 * sizeof (bfd_vma))
+
+/* Check whether [low1, high1) can be combined with [low2, high2),
+   i.e., they touch or overlap.  */
+static bool ranges_overlap(bfd_vma low1, bfd_vma high1, bfd_vma low2, bfd_=
vma high2)
+{
+  if (low1 =3D=3D low2 || high1 =3D=3D high2)
+    return true;
+
+  /* Sort so that low1 is below low2. */
+  if (low1 > low2)
+    {
+      bfd_vma tmp;
+
+      tmp =3D low1;
+      low1 =3D low2;
+      low2 =3D tmp;
+
+      tmp =3D high1;
+      high1 =3D high2;
+      high2 =3D tmp;
+    }
+
+  /* We touch iff low2 =3D=3D high1.
+     We overlap iff low2 is within [low1, high1). */
+  return (low2 <=3D high1);
+}
+
+/* Insert an address range in the trie mapping addresses to compilation un=
its.
+   Will return the new trie node (usually the same as is being sent in, bu=
t
+   in case of a leaf-to-interior conversion, or expansion of a leaf, it ma=
y be
+   different), or NULL on failure.
+ */
+static struct trie_node *insert_arange_in_trie(bfd *abfd,
+					       struct trie_node *trie,
+					       bfd_vma trie_pc,
+					       int trie_pc_bits,
+					       const struct comp_unit *unit,
+					       bfd_vma low_pc,
+					       bfd_vma high_pc)
+{
+  bfd_vma clamped_low_pc, clamped_high_pc;
+  int ch, from_ch, to_ch;
+  bool is_full_leaf =3D false;
+
+  /* See if we can extend any of the existing ranges.  This merging
+     isn't perfect (if merging opens up the possibility of merging two exi=
sting
+     ranges, we won't find them), but it takes the majority of the cases. =
 */
+  if (trie->num_room_in_leaf > 0)
+    {
+      struct trie_leaf *leaf =3D (struct trie_leaf *) trie;
+      int i;
+
+      for (i =3D 0; i < leaf->num_stored_in_leaf; ++i)
+	{
+	  if (leaf->ranges[i].unit =3D=3D unit &&
+	      ranges_overlap(low_pc, high_pc,
+			     leaf->ranges[i].low_pc, leaf->ranges[i].high_pc))
+	    {
+	      if (low_pc < leaf->ranges[i].low_pc)
+		leaf->ranges[i].low_pc =3D low_pc;
+	      if (high_pc > leaf->ranges[i].high_pc)
+		leaf->ranges[i].high_pc =3D high_pc;
+	      return trie;
+	    }
+	}
+
+      is_full_leaf =3D leaf->num_stored_in_leaf =3D=3D trie->num_room_in_l=
eaf;
+    }
+
+  /* If we're a leaf with no more room and we're _not_ at the bottom,
+     convert to an interior node.  */
+  if (is_full_leaf && trie_pc_bits < (int)VMA_BITS)
+    {
+      const struct trie_leaf *leaf =3D (struct trie_leaf *) trie;
+      int i;
+
+      trie =3D (struct trie_node *) bfd_zalloc (abfd, sizeof (struct trie_=
interior));
+      if (!trie)
+	return NULL;
+      is_full_leaf =3D false;
+
+      /* TODO: If we wanted to save a little more memory at the cost of
+	 complexity, we could have reused the old leaf node as one of the
+	 children of the new interior node, instead of throwing it away.  */
+      for (i =3D 0; i < leaf->num_stored_in_leaf; ++i)
+        {
+	  if (!insert_arange_in_trie (abfd, trie, trie_pc, trie_pc_bits,
+				      leaf->ranges[i].unit, leaf->ranges[i].low_pc,
+				      leaf->ranges[i].high_pc))
+	    return NULL;
+	}
+    }
+
+  /* If we're a leaf with no more room and we _are_ at the bottom,
+     we have no choice but to just make it larger. */
+  if (is_full_leaf)
+    {
+      const struct trie_leaf *leaf =3D (struct trie_leaf *) trie;
+      int new_room_in_leaf =3D trie->num_room_in_leaf * 2;
+      struct trie_leaf *new_leaf;
+
+      new_leaf =3D (struct trie_leaf *) bfd_zalloc (abfd,
+	sizeof (struct trie_leaf) + (new_room_in_leaf - TRIE_LEAF_SIZE) * sizeof =
(leaf->ranges[0]));
+      new_leaf->head.num_room_in_leaf =3D new_room_in_leaf;
+      new_leaf->num_stored_in_leaf =3D leaf->num_stored_in_leaf;
+
+      memcpy (new_leaf->ranges,
+	      leaf->ranges,
+	      leaf->num_stored_in_leaf * sizeof (leaf->ranges[0]));
+      trie =3D (struct trie_node *) new_leaf;
+      is_full_leaf =3D false;
+
+      /* Now the insert below will go through.  */
+    }
+
+  /* If we're a leaf (now with room), we can just insert at the end.  */
+  if (trie->num_room_in_leaf > 0)
+    {
+      struct trie_leaf *leaf =3D (struct trie_leaf *) trie;
+
+      int i =3D leaf->num_stored_in_leaf++;
+      leaf->ranges[i].unit =3D unit;
+      leaf->ranges[i].low_pc =3D low_pc;
+      leaf->ranges[i].high_pc =3D high_pc;
+      return trie;
+    }
+
+  /* Now we are definitely an interior node, so recurse into all the relev=
ant buckets.  */
+
+  /* Clamp the range to the current trie bucket.  */
+  clamped_low_pc =3D low_pc;
+  clamped_high_pc =3D high_pc;
+  if (trie_pc_bits > 0)
+    {
+      bfd_vma bucket_high_pc =3D trie_pc + ((bfd_vma)-1 >> trie_pc_bits); =
 /* Inclusive.  */
+      if (clamped_low_pc < trie_pc)
+	clamped_low_pc =3D trie_pc;
+      if (clamped_high_pc > bucket_high_pc)
+	clamped_high_pc =3D bucket_high_pc;
+    }
+
+  /* Insert the ranges in all buckets that it spans.  */
+  from_ch =3D (clamped_low_pc >> (VMA_BITS - trie_pc_bits - 8)) & 0xff;
+  to_ch =3D ((clamped_high_pc - 1) >> (VMA_BITS - trie_pc_bits - 8)) & 0xf=
f;
+  for (ch =3D from_ch; ch <=3D to_ch; ++ch)
+    {
+      struct trie_interior *interior =3D (struct trie_interior *) trie;
+      struct trie_node *child =3D interior->children[ch];
+
+      if (child =3D=3D NULL)
+        {
+	  child =3D alloc_trie_leaf (abfd);
+	  if (!child)
+	    return NULL;
+	}
+      child =3D insert_arange_in_trie (abfd,
+				     child,
+				     trie_pc + ((bfd_vma)ch << (VMA_BITS - trie_pc_bits - 8)),
+				     trie_pc_bits + 8,
+				     unit,
+				     low_pc,
+				     high_pc);
+      if (!child)
+	return NULL;
+
+      interior->children[ch] =3D child;
+    }
+
+    return trie;
+}
+
+
 static bool
 arange_add (const struct comp_unit *unit, struct arange *first_arange,
-	    bfd_vma low_pc, bfd_vma high_pc)
+	    struct trie_node **trie_root, bfd_vma low_pc, bfd_vma high_pc)
 {
   struct arange *arange;
=20
@@ -1777,6 +2036,19 @@ arange_add (const struct comp_unit *unit, struct ara=
nge *first_arange,
   if (low_pc =3D=3D high_pc)
     return true;
=20
+  if (trie_root !=3D NULL)
+    {
+      *trie_root =3D insert_arange_in_trie (unit->file->bfd_ptr,
+					  *trie_root,
+					  0,
+					  0,
+					  unit,
+					  low_pc,
+					  high_pc);
+      if (*trie_root =3D=3D NULL)
+	return false;
+    }
+
   /* If the first arange is empty, use it.  */
   if (first_arange->high =3D=3D 0)
     {
@@ -2411,7 +2683,7 @@ decode_line_info (struct comp_unit *unit)
 		    low_pc =3D address;
 		  if (address > high_pc)
 		    high_pc =3D address;
-		  if (!arange_add (unit, &unit->arange, low_pc, high_pc))
+		  if (!arange_add (unit, &unit->arange, &unit->file->trie_root, low_pc, =
high_pc))
 		    goto line_fail;
 		  break;
 		case DW_LNE_set_address:
@@ -3134,7 +3406,7 @@ find_abstract_instance (struct comp_unit *unit,
=20
 static bool
 read_ranges (struct comp_unit *unit, struct arange *arange,
-	     bfd_uint64_t offset)
+	     struct trie_node **trie_root, bfd_uint64_t offset)
 {
   bfd_byte *ranges_ptr;
   bfd_byte *ranges_end;
@@ -3169,7 +3441,7 @@ read_ranges (struct comp_unit *unit, struct arange *a=
range,
 	base_address =3D high_pc;
       else
 	{
-	  if (!arange_add (unit, arange,
+	  if (!arange_add (unit, arange, trie_root,
 			   base_address + low_pc, base_address + high_pc))
 	    return false;
 	}
@@ -3179,7 +3451,7 @@ read_ranges (struct comp_unit *unit, struct arange *a=
range,
=20
 static bool
 read_rnglists (struct comp_unit *unit, struct arange *arange,
-	       bfd_uint64_t offset)
+	       struct trie_node **trie_root, bfd_uint64_t offset)
 {
   bfd_byte *rngs_ptr;
   bfd_byte *rngs_end;
@@ -3253,19 +3525,19 @@ read_rnglists (struct comp_unit *unit, struct arang=
e *arange,
 	  return false;
 	}
=20
-      if (!arange_add (unit, arange, low_pc, high_pc))
+      if (!arange_add (unit, arange, trie_root, low_pc, high_pc))
 	return false;
     }
 }
=20
 static bool
 read_rangelist (struct comp_unit *unit, struct arange *arange,
-		bfd_uint64_t offset)
+		struct trie_node **trie_root, bfd_uint64_t offset)
 {
   if (unit->version <=3D 4)
-    return read_ranges (unit, arange, offset);
+    return read_ranges (unit, arange, trie_root, offset);
   else
-    return read_rnglists (unit, arange, offset);
+    return read_rnglists (unit, arange, trie_root, offset);
 }
=20
 static struct funcinfo *
@@ -3617,7 +3889,7 @@ scan_unit_for_symbols (struct comp_unit *unit)
=20
 		case DW_AT_ranges:
 		  if (is_int_form (&attr)
-		      && !read_rangelist (unit, &func->arange, attr.u.val))
+		      && !read_rangelist (unit, &func->arange, &unit->file->trie_root, a=
ttr.u.val))
 		    goto fail;
 		  break;
=20
@@ -3733,7 +4005,7 @@ scan_unit_for_symbols (struct comp_unit *unit)
=20
       if (func && high_pc !=3D 0)
 	{
-	  if (!arange_add (unit, &func->arange, low_pc, high_pc))
+	  if (!arange_add (unit, &func->arange, &unit->file->trie_root, low_pc, h=
igh_pc))
 	    goto fail;
 	}
     }
@@ -3931,7 +4203,7 @@ parse_comp_unit (struct dwarf2_debug *stash,
=20
 	case DW_AT_ranges:
 	  if (is_int_form (&attr)
-	      && !read_rangelist (unit, &unit->arange, attr.u.val))
+	      && !read_rangelist (unit, &unit->arange, &unit->file->trie_root, at=
tr.u.val))
 	    return NULL;
 	  break;
=20
@@ -3973,7 +4245,7 @@ parse_comp_unit (struct dwarf2_debug *stash,
     high_pc +=3D low_pc;
   if (high_pc !=3D 0)
     {
-      if (!arange_add (unit, &unit->arange, low_pc, high_pc))
+      if (!arange_add (unit, &unit->arange, &unit->file->trie_root, low_pc=
, high_pc))
 	return NULL;
     }
=20
@@ -4772,6 +5044,14 @@ _bfd_dwarf2_slurp_debug_info (bfd *abfd, bfd *debug_=
bfd,
   if (!stash->alt.abbrev_offsets)
     return false;
=20
+  stash->f.trie_root =3D alloc_trie_leaf (abfd);
+  if (!stash->f.trie_root)
+    return false;
+
+  stash->alt.trie_root =3D alloc_trie_leaf (abfd);
+  if (!stash->alt.trie_root)
+    return false;
+
   *pinfo =3D stash;
=20
   if (debug_bfd =3D=3D NULL)
@@ -4943,6 +5223,12 @@ stash_comp_unit (struct dwarf2_debug *stash, struct =
dwarf2_debug_file *file)
 	  each->next_unit =3D file->all_comp_units;
 	  file->all_comp_units =3D each;
=20
+	  if (each->arange.high =3D=3D 0)
+	    {
+	      each->next_unit_without_ranges =3D file->all_comp_units_without_ran=
ges;
+	      file->all_comp_units_without_ranges =3D each->next_unit_without_ran=
ges;
+	    }
+
 	  file->info_ptr +=3D length;
 	  return each;
 	}
@@ -5185,17 +5471,67 @@ _bfd_dwarf2_find_nearest_line (bfd *abfd,
     }
   else
     {
-      for (each =3D stash->f.all_comp_units; each; each =3D each->next_uni=
t)
+      struct trie_node *trie =3D stash->f.trie_root;
+      int bits =3D VMA_BITS - 8;
+      struct comp_unit **prev_each;
+
+      /* Traverse interior nodes until we get to a leaf.  */
+      while (trie && trie->num_room_in_leaf =3D=3D 0)
 	{
-	  found =3D ((each->arange.high =3D=3D 0
-		    || comp_unit_contains_address (each, addr))
-		   && comp_unit_find_nearest_line (each, addr,
+	  int ch =3D (addr >> bits) & 0xff;
+	  trie =3D ((struct trie_interior *) trie)->children[ch];
+	  bits -=3D 8;
+	}
+
+      if (trie)
+	{
+	  const struct trie_leaf *leaf =3D (struct trie_leaf *) trie;
+	  int i;
+
+	  for (i =3D 0; i < leaf->num_stored_in_leaf; ++i)
+	    {
+	      struct comp_unit *unit =3D (struct comp_unit *) leaf->ranges[i].uni=
t;
+	      unit->mark =3D false;
+	    }
+
+	  for (i =3D 0; i < leaf->num_stored_in_leaf; ++i)
+	    {
+	      struct comp_unit *unit =3D (struct comp_unit *) leaf->ranges[i].uni=
t;
+	      if (unit->mark ||
+	          addr < leaf->ranges[i].low_pc ||
+	          addr >=3D leaf->ranges[i].high_pc)
+	        continue;
+	      unit->mark =3D true;
+
+	      found =3D comp_unit_find_nearest_line (unit, addr,
 						   filename_ptr,
 						   &function,
 						   linenumber_ptr,
-						   discriminator_ptr));
+						   discriminator_ptr);
+	      if (found)
+		goto done;
+	   }
+	}
+
+      /* Also scan through all compilation units without any ranges,
+         taking them out of the list if they have acquired any since last =
time.  */
+      prev_each =3D &stash->f.all_comp_units_without_ranges;
+      for (each =3D *prev_each; each; each =3D each->next_unit_without_ran=
ges)
+        {
+	  if (each->arange.high !=3D 0)
+	    {
+	      *prev_each =3D each->next_unit_without_ranges;
+	      continue;
+	    }
+
+	  found =3D comp_unit_find_nearest_line (each, addr,
+					       filename_ptr,
+					       &function,
+					       linenumber_ptr,
+					       discriminator_ptr);
 	  if (found)
 	    goto done;
+	  prev_each =3D &each->next_unit_without_ranges;
 	}
     }
=20
--=20
2.35.1

