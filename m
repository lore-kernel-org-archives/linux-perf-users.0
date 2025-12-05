Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BEC1DB356
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Dec 2025 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764938187; cv=none; b=hdOJVN1fx1msi6jHneMBugL8pA14TISBFI4h/dAvXLsFPns8Vqw2e2G9tBsSMFpzga+A8mFvhScA98fThrH9ZuGI3lR2wGUvCJWC24I3PkwxhzKT2PHdylGm3EL3qnxZZ9MXnDXgxCxrgKd3UWyo8abcM0DeFfTkPbM96r/MxnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764938187; c=relaxed/simple;
	bh=u79PSkd4QSSessQ0JQUCrbqEOMNI+o40oP3+gYgfHkM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eTmXwK4k0HBtTgLuXwuG2qud4AQNdX5EL59bcS3VaBOVSILHy97sVc8Py0/kWABBQbHhxwqVmjHu6Kp9fcp4RiVxpR7/T6lLDi1wF6+HwJJlBNmk/RnH7IwFLezcvC3Vd0l76EhRwEbBk0sG0T9pYbP0d0s8E8DDEUk4Subl0ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EB8QEqGi; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sesse.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EB8QEqGi"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b478551a6so1119917f8f.1
        for <linux-perf-users@vger.kernel.org>; Fri, 05 Dec 2025 04:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764938182; x=1765542982; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kRYxdVDVf6CyXymAkRTsT5jDE27JC3hvhSrwESmuEeM=;
        b=EB8QEqGiE5nL6msXlMQ29xtBJGX9fLMYIkUJ7QkffOEsXRoMxYS8gmkg/E6R8m2BZH
         P4b/0Tjjo1TGJkPoJxFf9QlRTdHMk8eqI/ClP8cJPvKNSxFF4dhe/d6qK+nNJx8t01pK
         JAtvgFIKjEmA2M0ttAgmH4t2VtUfhbo+zAzP3/V1JeExJPjoxMQiaGigQ0mbEjcDOl+Q
         bqYxRE/EJoUKZEVrICgpVx+/DzNiLeYZMKiazV1A0iBAjXXWy6AgEBzb2pSGkKxDrJ1n
         Y8lvELduyFel870cFgtLvELoM6Gm8yyc+hOCJYJswyljfjeRfgvnt6yerT+Pq7Ww1ZQH
         ErXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764938182; x=1765542982;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kRYxdVDVf6CyXymAkRTsT5jDE27JC3hvhSrwESmuEeM=;
        b=mO/84+D8TOIva753KQ5JCsShcQt+Mu/P/W3zFm9R/2OxEh1nBC85BA5qMq8ASvIRJ4
         zv7biMT4J2PcFM5r4ZsdSdDv8vwlfVqW+joF/s4Nv3VcyLuLKAhrl4hGiMlu3/IMTC1R
         68Q+eoJ+GiyzvjfxHZ2XIHmAYBAhG2M9bcIEbGBlAr9RlK7OyupMeZHl5c/j/0RKXR4w
         3atKO2TSTAgpFQZyAW/bz5mhosz//cBgQ5Qh/9HG9Uglgs+8SGeI1nlHM5RQRoiwlIPR
         Wly04arYYGq6EQJ4iLdbL5YVzKuV3lzNlKfJ4tNXe10ZkIuFif74TAzhfe9lgGPnRZU/
         96Xg==
X-Gm-Message-State: AOJu0YwvXVLLsl3M/sjrwIsGffJBy7pYzPDs7/H9wCSb2OP8KULdS10n
	V/HCBnSdO+dAG2gSNP7VVCNEpP7B0CwyffPSTThi97om4+giM6LXA3mhs37EwIdaLaF9wml0AX7
	luw==
X-Google-Smtp-Source: AGHT+IGYEA/ir0bG+MCGIs33rE4NR8HAd0nsCJoNghYReGq/I1wa9eQsnXlEh94HEt/TYo/dXHA9EuaM8g==
X-Received: from wroq8.prod.google.com ([2002:adf:f508:0:b0:42b:3625:1d62])
 (user=sesse job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2288:b0:42b:40b5:e681
 with SMTP id ffacd0b85a97d-42f731870eemr9485118f8f.26.1764938181596; Fri, 05
 Dec 2025 04:36:21 -0800 (PST)
Date: Fri,  5 Dec 2025 13:36:08 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Message-ID: <20251205123608.3125691-1-sesse@google.com>
Subject: [PATCH] perf probe: Improve C++ support in arguments
From: "Steinar H. Gunderson" <sesse@google.com>
To: acme@kernel.org
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	irogers@google.com, "Steinar H. Gunderson" <sesse@google.com>
Content-Type: text/plain; charset="UTF-8"

For purposes of specifying arguments in tracepoints, C++ classes
work exactly like structs, and C++ references work almost exactly
like pointers (they are dereferenced with . instead of ->).
However, they use different tags in DWARF, which means you cannot
use them in arguments.

Implement support for both, based on the existing struct and pointer
support. This allows us to to something like this in Chromium:

  perf probe --exec content_shell --add 'PerformanceMark=\
_ZN5blink15PerformanceMark6CreateEPNS_11ScriptStateERKNS_12\
AtomicStringEPNS_22PerformanceMarkOptionsERNS_14ExceptionStateE \
mark_name.string_.impl_.ptr_'

even though mark_name is an class AtomicString&.

We don't support advanced C++ features, such as operator overloading.
Unfortunately, we also don't support C++-style strings where there
is a separate length field instead of null-termination. We also cannot
go past ptr_ in the example above (e.g. add ->length_), due to
unrelated DWARF issues.

Signed-off-by: Steinar H. Gunderson <sesse@google.com>
Cc: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate-data.c |  3 ++-
 tools/perf/util/dwarf-aux.c     | 13 ++++++++++---
 tools/perf/util/probe-finder.c  | 24 +++++++++++++++++-------
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 07cf9c334be0..d97b5fc61e6f 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -459,7 +459,8 @@ static bool is_pointer_type(Dwarf_Die *type_die)
 {
 	int tag = dwarf_tag(type_die);
 
-	return tag == DW_TAG_pointer_type || tag == DW_TAG_array_type;
+	return tag == DW_TAG_pointer_type || tag == DW_TAG_reference_type ||
+	       tag == DW_TAG_array_type;
 }
 
 static bool is_compound_type(Dwarf_Die *type_die)
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 9267af204c7d..25bbc840d1a8 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1112,6 +1112,8 @@ int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
 	tag = dwarf_tag(type_die);
 	if (tag == DW_TAG_pointer_type)
 		tmp = "*";
+	else if (tag == DW_TAG_reference_type)
+		tmp = "&";
 	else if (tag == DW_TAG_array_type)
 		tmp = "[]";
 	else if (tag == DW_TAG_subroutine_type) {
@@ -1124,6 +1126,8 @@ int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
 			tmp = "union ";
 		else if (tag == DW_TAG_structure_type)
 			tmp = "struct ";
+		else if (tag == DW_TAG_class_type)
+			tmp = "class ";
 		else if (tag == DW_TAG_enumeration_type)
 			tmp = "enum ";
 		else if (name == NULL)
@@ -2065,7 +2069,8 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
 
 	tag = dwarf_tag(type_die);
 	/* If it's not a compound type, return the type directly */
-	if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
+	if (tag != DW_TAG_structure_type && tag != DW_TAG_class_type &&
+	    tag != DW_TAG_union_type) {
 		Dwarf_Word size;
 
 		if (dwarf_aggregate_size(type_die, &size) < 0)
@@ -2080,7 +2085,8 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
 
 	mb_type = *type_die;
 	/* TODO: Handle union types better? */
-	while (tag == DW_TAG_structure_type || tag == DW_TAG_union_type) {
+	while (tag == DW_TAG_structure_type || tag == DW_TAG_class_type ||
+	       tag == DW_TAG_union_type) {
 		member = die_find_child(&mb_type, __die_find_member_offset_cb,
 					(void *)(long)offset, die_mem);
 		if (member == NULL)
@@ -2091,7 +2097,8 @@ Dwarf_Die *die_get_member_type(Dwarf_Die *type_die, int offset,
 
 		tag = dwarf_tag(&mb_type);
 
-		if (tag == DW_TAG_structure_type || tag == DW_TAG_union_type) {
+		if (tag == DW_TAG_structure_type || tag == DW_TAG_class_type ||
+		    tag == DW_TAG_union_type) {
 			Dwarf_Word loc;
 
 			/* Update offset for the start of the member struct */
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 5ffd97ee4898..ca4734c75bba 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -360,12 +360,20 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 		ref->offset += dwarf_bytesize(&type) * field->index;
 		ref->user_access = user_access;
 		goto next;
-	} else if (tag == DW_TAG_pointer_type) {
+	} else if (tag == DW_TAG_pointer_type || tag == DW_TAG_reference_type) {
 		/* Check the pointer and dereference */
-		if (!field->ref) {
-			pr_err("Semantic error: %s must be referred by '->'\n",
-			       field->name);
-			return -EINVAL;
+		if (tag == DW_TAG_pointer_type) {
+			if (!field->ref) {
+				pr_err("Semantic error: %s must be referred by '->'\n",
+				       field->name);
+				return -EINVAL;
+			}
+		} else {
+			if (field->ref) {
+				pr_err("Semantic error: %s must be referred by '.'\n",
+				       field->name);
+				return -EINVAL;
+			}
 		}
 		/* Get the type pointed by this pointer */
 		if (die_get_real_type(&type, &type) == NULL) {
@@ -374,7 +382,8 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 		}
 		/* Verify it is a data structure  */
 		tag = dwarf_tag(&type);
-		if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
+		if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type &&
+		    tag != DW_TAG_class_type) {
 			pr_warning("%s is not a data structure nor a union.\n",
 				   varname);
 			return -EINVAL;
@@ -389,7 +398,8 @@ static int convert_variable_fields(Dwarf_Die *vr_die, const char *varname,
 			*ref_ptr = ref;
 	} else {
 		/* Verify it is a data structure  */
-		if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type) {
+		if (tag != DW_TAG_structure_type && tag != DW_TAG_union_type &&
+		    tag != DW_TAG_class_type) {
 			pr_warning("%s is not a data structure nor a union.\n",
 				   varname);
 			return -EINVAL;
-- 
2.51.0

