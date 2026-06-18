Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86EE3FBED2;
	Thu, 18 Jun 2026 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795785; cv=none; b=k++x++A+DbUlNis7eSGJvx9DKXZg4beIjjlX4aJ0Zdf33X9tOTudNv9jAP+CI2U6hgTDhJwWgmUCNvTZVXXvwL0/JfWT5MSQIgnMxA3YU5LoUMrcw8qhxgkHCQy5a4dIF2ZwCtutIBmK3vmDHzgbl9EklQTbLlJhGXlCjCYaUow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795785; c=relaxed/simple;
	bh=5kxfL0ymOzaZSbqsAAbdSNVCexwpsXNLqhYIGUjsS1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cn+dq2T0HC6UKMOwomXb+EB+UREjQUfzDmS9VhpOA2Vsb4S3re6qief9NDikp1x5gRvk1+MyQ3c94GgenbWg/dQ2Mb0m8EIzMOSWYLtWvEB7YAgK8d5hfIUfB8oL08thN1MeSAeLC5UEIW4+TgAquUcLsTWJ750mjbWbl91i3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEEUgEgI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEEUgEgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8051F00A3A;
	Thu, 18 Jun 2026 15:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795783;
	bh=Xkq84+Ewf1brYEuWLP68V2MqN+pheFgcelLFvixreU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZEEUgEgItZ+n9qGrVwY7H6PQHTqtRESEhF84AkaQSbDj+6Qcu9A345MYoOfwCETuO
	 xYOF6zsVF8hh00jSD1hmknxhdRY4w4rZKyKblu8HAT6Pxrd2vNZ3xuJ/pbfemk1vyD
	 dKP07aBQMhfRjvnPt9xvwFVhDS5M9tjr3gN5C84ljeDFQQdgzPqIoAd3uZPvjVaHaj
	 U04m0z06zfEe0PdrA8/HgnLClFyJ4Du/OKWKxAVUHY0BHOa5pKP2AVtqi6E5sOf9Sn
	 y/CoVm7FGivvXvvF9XKDndbUWGWqDqB7disnldbEwl1wsq5w7za0jVINJpb3UJWUwP
	 NiLtPlsIY21dw==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH 3/7] dwarf_loader: Initial support for DW_TAG_subprogram in DW_TAG_enumeration
Date: Thu, 18 Jun 2026 12:16:02 -0300
Message-ID: <20260618151606.82747-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618151606.82747-1-acme@kernel.org>
References: <20260618151606.82747-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In Rust enums can have subprograms, add initial support for it.

Example of a Rust enumeration with a DW_TAG_subprogram tag.

  $ pahole -C ProgramKind /tmp/build/perf-tools-next/tests/workloads/code_with_type.a
  enum ProgramKind {
  	PathLookup = 0,
  	Relative   = 1,
  	Absolute   = 2,
  	enum ProgramKind new(struct &std::ffi::os_str::OsStr),
  } __attribute__((__packed__));
  $

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 btf_encoder.c     | 13 +++++++++----
 ctf_encoder.c     | 16 +++++++++++-----
 dwarf_loader.c    | 39 +++++++++++++++++++++++++++++++--------
 dwarves.c         |  3 +++
 dwarves.h         |  2 +-
 dwarves_emit.c    | 10 +++++-----
 dwarves_fprintf.c | 44 ++++++++++++++++++++++++++++++++------------
 pahole.c          |  9 ++++++---
 8 files changed, 98 insertions(+), 38 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 633bc6162ce013d0..be880f3fdb32f792 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1786,7 +1786,7 @@ static uint32_t array_type__nelems(struct tag *tag)
 }
 
 static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, struct tag *tag,
-					  struct conf_load *conf_load)
+					  const struct cu *cu, struct conf_load *conf_load)
 {
 	struct type *etype = tag__type(tag);
 	struct enumerator *pos;
@@ -1798,6 +1798,11 @@ static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, struct ta
 		return type_id;
 
 	type__for_each_enumerator(etype, pos) {
+		if (pos->tag.tag != DW_TAG_enumerator) {
+			fprintf(stderr, "Unexpected DW_TAG_%s <%llx>, skipping it...\n",
+				dwarf_tag_name(tag->tag), tag__orig_id(tag, cu));
+			continue;
+		}
 		name = enumerator__name(pos);
 		if (btf_encoder__add_enum_val(encoder, name, pos->value, etype, conf_load))
 			return -1;
@@ -1807,7 +1812,7 @@ static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, struct ta
 }
 
 static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
-				   struct conf_load *conf_load)
+				   const struct cu *cu, struct conf_load *conf_load)
 {
 	/* single out type 0 as it represents special type "void" */
 	uint32_t ref_type_id = tag->type == 0 ? 0 : encoder->type_id_off + tag->type;
@@ -1846,7 +1851,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
 		encoder->need_index_type = true;
 		return btf_encoder__add_array(encoder, ref_type_id, encoder->array_index_id, array_type__nelems(tag));
 	case DW_TAG_enumeration_type:
-		return btf_encoder__add_enum_type(encoder, tag, conf_load);
+		return btf_encoder__add_enum_type(encoder, tag, cu, conf_load);
 	case DW_TAG_subroutine_type:
 		return btf_encoder__add_func_proto_for_ftype(encoder, tag__ftype(tag));
         case DW_TAG_unspecified_type:
@@ -2905,7 +2910,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
 	}
 
 	cu__for_each_type(cu, core_id, pos) {
-		btf_type_id = btf_encoder__encode_tag(encoder, pos, conf_load);
+		btf_type_id = btf_encoder__encode_tag(encoder, pos, cu, conf_load);
 
 		if (btf_type_id == 0) {
 			++skipped_types;
diff --git a/ctf_encoder.c b/ctf_encoder.c
index b761287d45348c59..1c61c76ba20e06bc 100644
--- a/ctf_encoder.c
+++ b/ctf_encoder.c
@@ -142,7 +142,7 @@ static int subroutine_type__encode(struct tag *tag, uint32_t core_id, struct ctf
 	return 0;
 }
 
-static int enumeration_type__encode(struct tag *tag, uint32_t core_id, struct ctf *ctf)
+static int enumeration_type__encode(struct tag *tag, const struct cu *cu, uint32_t core_id, struct ctf *ctf)
 {
 	struct type *etype = tag__type(tag);
 	int64_t position;
@@ -154,13 +154,19 @@ static int enumeration_type__encode(struct tag *tag, uint32_t core_id, struct ct
 		return -1;
 
 	struct enumerator *pos;
-	type__for_each_enumerator(etype, pos)
+	type__for_each_enumerator(etype, pos) {
+		if (pos->tag.tag != DW_TAG_enumerator) {
+			fprintf(stderr, "Unexpected DW_TAG_%s <%llx>, skipping it...\n",
+				dwarf_tag_name(tag->tag), tag__orig_id(tag, cu));
+			continue;
+		}
 		ctf__add_enumerator(ctf, pos->name, pos->value, &position);
+	}
 
 	return 0;
 }
 
-static void tag__encode_ctf(struct tag *tag, uint32_t core_id, struct ctf *ctf)
+static void tag__encode_ctf(struct tag *tag, const struct cu *cu, uint32_t core_id, struct ctf *ctf)
 {
 	switch (tag->tag) {
 	case DW_TAG_base_type:
@@ -190,7 +196,7 @@ static void tag__encode_ctf(struct tag *tag, uint32_t core_id, struct ctf *ctf)
 		subroutine_type__encode(tag, core_id, ctf);
 		break;
 	case DW_TAG_enumeration_type:
-		enumeration_type__encode(tag, core_id, ctf);
+		enumeration_type__encode(tag, cu, core_id, ctf);
 		break;
 	}
 }
@@ -253,7 +259,7 @@ int cu__encode_ctf(struct cu *cu, int verbose)
 	uint32_t id;
 	struct tag *pos;
 	cu__for_each_type(cu, id, pos)
-		tag__encode_ctf(pos, id, ctf);
+		tag__encode_ctf(pos, cu, id, ctf);
 
 	struct hlist_head hash_addr[HASHADDR__SIZE];
 
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 54cc66748ef685fc..2a62059dc66517dc 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -1943,6 +1943,8 @@ out_delete:
 	return NULL;
 }
 
+static struct tag *die__create_new_function(Dwarf_Die *die, struct cu *cu, struct conf_load *conf);
+
 static struct tag *die__create_new_enumeration(Dwarf_Die *die, struct cu *cu, struct conf_load *conf)
 {
 	Dwarf_Die child;
@@ -1964,18 +1966,39 @@ static struct tag *die__create_new_enumeration(Dwarf_Die *die, struct cu *cu, st
 
 	die = &child;
 	do {
-		struct enumerator *enumerator;
+		switch (dwarf_tag(die)) {
+		case DW_TAG_enumerator: {
+			struct enumerator *enumerator = enumerator__new(die, cu, conf);
+
+			if (enumerator == NULL)
+				goto out_delete;
+
+			enumeration__add(enumeration, enumerator);
+			cu__hash(cu, &enumerator->tag);
+		}
+			continue;
+		case DW_TAG_subprogram: {
+			struct tag *tag = die__create_new_function(die, cu, conf);
+			uint32_t id;
+
+			if (tag == NULL)
+				goto out_delete;
+
+			if (cu__table_add_tag(cu, tag, &id) < 0) {
+				tag__delete(tag, cu);
+				goto out_delete;
+			}
 
-		if (dwarf_tag(die) != DW_TAG_enumerator) {
+			struct dwarf_tag *dtag = tag__dwarf(tag);
+			dtag->small_id = id;
+			namespace__add_tag(&enumeration->namespace, tag);
+			cu__hash(cu, tag);
+			break;
+		}
+		default:
 			cu__tag_not_handled(cu, die);
 			continue;
 		}
-		enumerator = enumerator__new(die, cu, conf);
-		if (enumerator == NULL)
-			goto out_delete;
-
-		enumeration__add(enumeration, enumerator);
-		cu__hash(cu, &enumerator->tag);
 	} while (dwarf_siblingof(die, die) == 0);
 out:
 	return &enumeration->namespace.tag;
diff --git a/dwarves.c b/dwarves.c
index 37f769ee65caad72..2af10588ff2f20c5 100644
--- a/dwarves.c
+++ b/dwarves.c
@@ -2015,6 +2015,9 @@ static void enumeration__calc_prefix(struct type *enumeration)
 	struct enumerator *entry;
 
 	type__for_each_enumerator(enumeration, entry) {
+		if (entry->tag.tag != DW_TAG_enumerator)
+			continue;
+
 		const char *curr_name = enumerator__name(entry);
 
 		if (previous_name) {
diff --git a/dwarves.h b/dwarves.h
index 6595c16434966f09..6ad2995d2e33be0d 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -1646,7 +1646,7 @@ static inline const char *enumerator__name(const struct enumerator *enumerator)
 
 void enumeration__delete(struct type *type, struct cu *cu);
 void enumeration__add(struct type *type, struct enumerator *enumerator);
-size_t enumeration__fprintf(const struct tag *tag_enum,
+size_t enumeration__fprintf(const struct tag *tag_enum, const struct cu *cu,
 			    const struct conf_fprintf *conf, FILE *fp);
 
 int dwarves__init(void);
diff --git a/dwarves_emit.c b/dwarves_emit.c
index 01b33b7ec41eb947..aaf0f8f9a7ea815a 100644
--- a/dwarves_emit.c
+++ b/dwarves_emit.c
@@ -100,7 +100,7 @@ static struct type *type_emissions__find_fwd_decl(const struct type_emissions *e
 	return NULL;
 }
 
-static int enumeration__emit_definitions(struct tag *tag,
+static int enumeration__emit_definitions(struct tag *tag, const struct cu *cu,
 					 struct type_emissions *emissions,
 					 const struct conf_fprintf *conf,
 					 FILE *fp)
@@ -121,7 +121,7 @@ static int enumeration__emit_definitions(struct tag *tag,
 		return 0;
 	}
 
-	enumeration__fprintf(tag, conf, fp);
+	enumeration__fprintf(tag, cu, conf, fp);
 	fputs(";\n", fp);
 
 	// See comment on enumeration__fprintf(), it seems this happens with DWARF as well
@@ -198,10 +198,10 @@ static int typedef__emit_definitions(struct tag *tdef, struct cu *cu,
 		if (type__name(ctype) == NULL) {
 			fputs("typedef ", fp);
 			conf.suffix = type__name(def);
-			enumeration__emit_definitions(type, emissions, &conf, fp);
+			enumeration__emit_definitions(type, cu, emissions, &conf, fp);
 			goto out;
 		} else
-			enumeration__emit_definitions(type, emissions, &conf, fp);
+			enumeration__emit_definitions(type, cu, emissions, &conf, fp);
 	}
 		break;
 	case DW_TAG_structure_type:
@@ -380,7 +380,7 @@ next_indirection:
 			struct conf_fprintf conf = {
 				.suffix = NULL,
 			};
-			return enumeration__emit_definitions(type, emissions, &conf, fp);
+			return enumeration__emit_definitions(type, cu, emissions, &conf, fp);
 		}
 		break;
 	case DW_TAG_structure_type:
diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
index 1ec478c2a027be10..a3c8b391b9222fcd 100644
--- a/dwarves_fprintf.c
+++ b/dwarves_fprintf.c
@@ -153,6 +153,8 @@ const char tabs[] = "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t";
 
 static size_t union__fprintf(struct type *type, const struct cu *cu,
 			     const struct conf_fprintf *conf, FILE *fp);
+static size_t function__fprintf(const struct tag *tag, const struct cu *cu,
+				const struct conf_fprintf *conf, FILE *fp);
 
 /*
  * In dwarves_emit.c we can call type__emit() using a locally setup conf_fprintf for which
@@ -404,7 +406,7 @@ next_type:
 		struct conf_fprintf tconf = *pconf;
 
 		tconf.suffix = type__name(type);
-		return printed + enumeration__fprintf(tag_type, &tconf, fp);
+		return printed + enumeration__fprintf(tag_type, cu, &tconf, fp);
 	}
 	}
 
@@ -448,7 +450,12 @@ static int enumeration__max_entry_name_len(struct type *type)
 	struct enumerator *pos;
 
 	type__for_each_enumerator(type, pos) {
-		int len = strlen(enumerator__name(pos));
+		int len = 0;
+
+		if (pos->tag.tag == DW_TAG_enumerator)
+			len = strlen(enumerator__name(pos));
+		else if (pos->tag.tag == DW_TAG_subprogram)
+			len = strlen(function__name(tag__function(&pos->tag)));
 
 		if (type->max_tag_name_len < len)
 			type->max_tag_name_len = len;
@@ -457,7 +464,8 @@ out:
 	return type->max_tag_name_len;
 }
 
-size_t enumeration__fprintf(const struct tag *tag, const struct conf_fprintf *conf, FILE *fp)
+size_t enumeration__fprintf(const struct tag *tag, const struct cu *cu,
+			    const struct conf_fprintf *conf, FILE *fp)
 {
 	struct type *type = tag__type(tag);
 	struct enumerator *pos;
@@ -478,13 +486,25 @@ size_t enumeration__fprintf(const struct tag *tag, const struct conf_fprintf *co
 	}
 
 	type__for_each_enumerator(type, pos) {
-		printed += fprintf(fp, "%.*s\t%-*s = ", indent, tabs,
-				   max_entry_name_len, enumerator__name(pos));
-		if (conf->hex_fmt)
-			printed += fprintf(fp, "%#llx", (unsigned long long)pos->value);
-		else
-			printed += fprintf(fp, type->is_signed_enum ?  "%lld" : "%llu",
-					   (unsigned long long)pos->value);
+		printed += fprintf(fp, "%.*s\t", indent, tabs);
+
+		switch (pos->tag.tag) {
+		case DW_TAG_subprogram:
+			function__fprintf(&pos->tag, cu, conf, fp);
+			break;
+		case DW_TAG_enumerator:
+			printed += fprintf(fp, "%-*s = ", max_entry_name_len, enumerator__name(pos));
+			if (conf->hex_fmt)
+				printed += fprintf(fp, "%#llx", (unsigned long long)pos->value);
+			else
+				printed += fprintf(fp, type->is_signed_enum ?  "%lld" : "%llu",
+						   (unsigned long long)pos->value);
+			break;
+		default:
+			printed += fprintf(fp, "/* Unexpected %s <%llx> */\n", dwarf_tag_name(tag->tag),
+					   tag__orig_id(tag, cu));
+			continue;
+		}
 		printed += fprintf(fp, ",\n");
 	}
 
@@ -934,7 +954,7 @@ print_modifier: {
 		if (type__name(ctype) != NULL && !expand_types)
 			printed += fprintf(fp, "enum %-*s %s", tconf.type_spacing - 5, type__name(ctype), name ?: "");
 		else
-			printed += enumeration__fprintf(type, &tconf, fp);
+			printed += enumeration__fprintf(type, cu, &tconf, fp);
 		break;
 	case DW_TAG_LLVM_annotation: {
 		struct tag *ttype = cu__type(cu, type->type);
@@ -2158,7 +2178,7 @@ size_t tag__fprintf(struct tag *tag, const struct cu *cu,
 		printed += array_type__fprintf(tag, cu, "array", pconf, fp);
 		break;
 	case DW_TAG_enumeration_type:
-		printed += enumeration__fprintf(tag, pconf, fp);
+		printed += enumeration__fprintf(tag, cu, pconf, fp);
 		break;
 	case DW_TAG_typedef:
 		printed += typedef__fprintf(tag, cu, pconf, fp);
diff --git a/pahole.c b/pahole.c
index 28d8f8832773520b..765da575f3dab39a 100644
--- a/pahole.c
+++ b/pahole.c
@@ -2155,7 +2155,7 @@ static const char *enumeration__lookup_value(struct type *enumeration, uint64_t
 	struct enumerator *entry;
 
 	type__for_each_enumerator(enumeration, entry) {
-		if (entry->value == value)
+		if (entry->tag.tag == DW_TAG_enumerator && entry->value == value)
 			return enumerator__name(entry);
 	}
 
@@ -2180,7 +2180,7 @@ static struct enumerator *enumeration__lookup_entry_from_value(struct type *enum
 	struct enumerator *entry;
 
 	type__for_each_enumerator(enumeration, entry) {
-		if (entry->value == value)
+		if (entry->tag.tag == DW_TAG_enumerator && entry->value == value)
 			return entry;
 	}
 
@@ -2206,6 +2206,9 @@ static struct enumerator *enumeration__find_enumerator(struct type *enumeration,
 	struct enumerator *entry;
 
 	type__for_each_enumerator(enumeration, entry) {
+		if (entry->tag.tag != DW_TAG_enumerator)
+			continue;
+
 		const char *entry_name = enumerator__name(entry);
 
 		if (!strcmp(entry_name, name))
@@ -3204,7 +3207,7 @@ static bool print_enumeration_with_enumerator(struct cu *cu, const char *name)
 
 	cu__for_each_enumeration(cu, id, enumeration) {
 		if (enumeration__find_enumerator(enumeration, name) != NULL) {
-			enumeration__fprintf(type__tag(enumeration), &conf, stdout);
+			enumeration__fprintf(type__tag(enumeration), cu, &conf, stdout);
 			fputc('\n', stdout);
 			return true;
 		}
-- 
2.54.0

