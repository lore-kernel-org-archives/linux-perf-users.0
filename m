Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245823FB7C0;
	Thu, 18 Jun 2026 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795778; cv=none; b=gFOeUDPicineedZF6JnT0t7VyyOLC9RtkbxA/TUo2fX357Hk0lXtnnPxn6A8dgBi1O4J9LhKo6VqT2IpjFyERyyFoo9msNUWAs97YfKZoM8rnATmS87KejnoXw0H39iGWBmbHeqLkuzVpHahwkuTysOnVpkjWvY2gCdDt/kE4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795778; c=relaxed/simple;
	bh=UwpGc8on0rEKqLi/gp95VcaN88Rd0zYdeGkzflKPiyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqcD9mcg70RpquwZTIPc+PDHDSaJcpHiKUM5ExZ91Tp/URino5BlJys0ZHjJCyvv31YA8UKyyyZQlt3zmwFRCh+1O7A5mI5vR/0SUqZAVmhBFlnLgp+OXrJDkClKM2havcU9PToa4GUZmJk8H3BdIm5A7spPuqNFfE+Ylb1w5Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnOglqV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnOglqV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079581F00A3A;
	Thu, 18 Jun 2026 15:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795776;
	bh=lnkFRM8D9ypBmHBgqsF+Iuf6T68nWJudVH/L7zvEN8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RnOglqV2cdb03PIDdEn/Xq/Avc1V4Z7Ox8v7TcCPTHGTEnJ9VaczaSaKc1r565pmX
	 dAjjUzW3AR/Xi1TkbNeJayZw4AKQ9jIKVmn0CvYv4HmeiDX6WSWqfrE+/NRb0o0FhG
	 k2sntT0ZFWFPRaRulgFzV/fJ5zhQ39cUZaWhE7zXHYkfru7td6Ijdw0IO2bv/nUSP8
	 UtJJMO68iVCaQ65fN1QJM+frmcuVkXlQJ7U53r2MxuadwRcE81/7Vf26YfS51zJfHR
	 RpuiCm5L30L8LsBLsLyNoemEjBaykLRJXRQabhSUiqN3kq8lzrjGNYUn+OwJA8KCn2
	 LzVZ2yteCG0TQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/7] dwarf_loader: Initial support for DW_TAG_variant_part
Date: Thu, 18 Jun 2026 12:16:00 -0300
Message-ID: <20260618151606.82747-2-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618151606.82747-1-acme@kernel.org>
References: <20260618151606.82747-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Still doesn't handle its sub hierarchy, i.e. the DW_TAG_variant entries
and its underlying DW_TAG_member entries.

This was noticed when running the regression test that uses a debug
build of perf to process a perf.data file and test pahole's pretty
printing features, as now perf has a synthetic workload that is written
in rust:

 <0><20c95a>: Abbrev Number: 1 (DW_TAG_compile_unit)
    <20c95b>   DW_AT_producer    : (indirect string, offset: 0x4ee5a): clang LLVM (rustc version 1.93.1 (01f6ddf75 2026-02-11) (Fedora 1.93.1-1.fc43))
    <20c95f>   DW_AT_language    : 28	(Rust)
    <20c961>   DW_AT_name        : (indirect string, offset: 0x4eeaa): tests/workloads/code_with_type.rs/@/code_with_type.d6e680867bfb8b27-cgu.0
    <20c965>   DW_AT_stmt_list   : 0x5e1ed
    <20c969>   DW_AT_comp_dir    : (indirect string, offset: 0x487f1): /home/acme/git/perf-tools/tools/perf
    <20c96d>   DW_AT_low_pc      : 0
    <20c975>   DW_AT_ranges      : 0x2d0
⬢ [acme@toolbx pahole]$

So lets add some scaffolding for the Rust DWARF constructs involved for
us to be able to continue using perf with DWARF to test the pretty
printing features.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c | 26 +++++++++++++++++++++++++-
 dwarves.c      | 25 +++++++++++++++++++++++++
 dwarves.h      | 16 ++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 16fb7becffee56f6..f0833e8c44a944a8 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -508,6 +508,8 @@ static void tag__init(struct tag *tag, struct cu *cu, Dwarf_Die *die)
 
 	if (tag->tag == DW_TAG_imported_module || tag->tag == DW_TAG_imported_declaration)
 		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_import);
+	else if (tag->tag == DW_TAG_variant_part)
+		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_discr);
 	else
 		dwarf_tag__set_attr_type(dtag, type, die, DW_AT_type);
 
@@ -1170,6 +1172,18 @@ static struct template_parameter_pack *template_parameter_pack__new(Dwarf_Die *d
 	return pack;
 }
 
+static struct variant_part *variant_part__new(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
+{
+	struct variant_part *vpart = tag__alloc(cu, sizeof(*vpart));
+
+	if (vpart != NULL) {
+		tag__init(&vpart->tag, cu, die);
+		INIT_LIST_HEAD(&vpart->variants);
+	}
+
+	return vpart;
+}
+
 /* Returns number of locations found or negative value for errors. */
 static ptrdiff_t __dwarf_getlocations(Dwarf_Attribute *attr,
 				      ptrdiff_t offset, Dwarf_Addr *basep,
@@ -1990,9 +2004,19 @@ static int die__process_class(Dwarf_Die *die, struct type *class,
 		case DW_TAG_GNU_template_template_param:
 #endif
 		case DW_TAG_subrange_type: // XXX: ADA stuff, its a type tho, will have other entries referencing it...
-		case DW_TAG_variant_part: // XXX: Rust stuff
 			tag__print_not_supported(die);
 			continue;
+		case DW_TAG_variant_part: {
+			struct variant_part *vpart = variant_part__new(die, cu, conf);
+
+			if (vpart == NULL)
+				return -ENOMEM;
+
+			// For rust it seems we have just one, but DWARF, according to Gemini, support having
+			// more than one DW_TAG_variant_part for a given DW_TAG_structure_type, so future proof it
+			type__add_variant_part(class, vpart);
+			continue;
+		}
 		case DW_TAG_template_type_parameter: {
 			struct template_type_param *ttparm = template_type_param__new(die, cu, conf);
 
diff --git a/dwarves.c b/dwarves.c
index ef93239d26827711..37f769ee65caad72 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -428,6 +428,7 @@ void __type__init(struct type *type)
 	INIT_LIST_HEAD(&type->type_enum);
 	INIT_LIST_HEAD(&type->template_type_params);
 	INIT_LIST_HEAD(&type->template_value_params);
+	INIT_LIST_HEAD(&type->variant_parts);
 	type->template_parameter_pack = NULL;
 	type->sizeof_member = NULL;
 	type->member_prefix = NULL;
@@ -1288,6 +1289,24 @@ static void type__delete_class_members(struct type *type, struct cu *cu)
 	}
 }
 
+static void variant_part__delete(struct variant_part *vpart, struct cu *cu)
+{
+	if (vpart == NULL)
+		return;
+
+	cu__tag_free(cu, &vpart->tag);
+}
+
+static void type__delete_variant_parts(struct type *type, struct cu *cu)
+{
+	struct variant_part *pos, *next;
+
+	type__for_each_variant_part_safe_reverse(type, pos, next) {
+		list_del_init(&pos->tag.node);
+		variant_part__delete(pos, cu);
+	}
+}
+
 void class__delete(struct class *class, struct cu *cu)
 {
 	if (class == NULL)
@@ -1303,6 +1322,7 @@ void type__delete(struct type *type, struct cu *cu)
 		return;
 
 	type__delete_class_members(type, cu);
+	type__delete_variant_parts(type, cu);
 
 	if (type->suffix_disambiguation)
 		zfree(&type->namespace.name);
@@ -1366,6 +1386,11 @@ void type__add_template_value_param(struct type *type, struct template_value_par
 	list_add_tail(&tvparam->tag.node, &type->template_value_params);
 }
 
+void type__add_variant_part(struct type *type, struct variant_part *vpart)
+{
+	list_add_tail(&vpart->tag.node, &type->variant_parts);
+}
+
 struct class_member *type__last_member(struct type *type)
 {
 	struct class_member *pos;
diff --git a/dwarves.h b/dwarves.h
index 5ec16e750e8359e3..4f3eac047f41edac 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1015,6 +1015,11 @@ static inline struct formal_parameter_pack *tag__formal_parameter_pack(const str
 
 void formal_parameter_pack__add(struct formal_parameter_pack *pack, struct parameter *param);
 
+struct variant_part {
+	struct tag	 tag;
+	struct list_head variants;
+};
+
 /*
  * tag.tag can be DW_TAG_subprogram_type or DW_TAG_subroutine_type.
  */
@@ -1285,6 +1290,7 @@ struct type {
 	uint8_t		 is_signed_enum:1;
 	struct list_head template_type_params;
 	struct list_head template_value_params;
+	struct list_head variant_parts;
 	struct template_parameter_pack *template_parameter_pack;
 };
 
@@ -1402,9 +1408,19 @@ static inline struct class_member *class_member__next(struct class_member *membe
 #define type__for_each_tag_safe_reverse(type, pos, n) \
 	list_for_each_entry_safe_reverse(pos, n, &(type)->namespace.tags, tag.node)
 
+/**
+ * type__for_each_variant_part_safe_reverse - safely iterate thru all variant_parts in a type, in reverse order
+ * @type: struct type instance to iterate
+ * @pos: struct variant_part iterator
+ * @n: struct variant_part temp iterator
+ */
+#define type__for_each_variant_part_safe_reverse(type, pos, n) \
+	list_for_each_entry_safe_reverse(pos, n, &(type)->variant_parts, tag.node)
+
 void type__add_member(struct type *type, struct class_member *member);
 void type__add_template_type_param(struct type *type, struct template_type_param *ttparm);
 void type__add_template_value_param(struct type *type, struct template_value_param *tvparam);
+void type__add_variant_part(struct type *type, struct variant_part *vpart);
 
 struct class_member *
 	type__find_first_biggest_size_base_type_member(struct type *type,
-- 
2.54.0

