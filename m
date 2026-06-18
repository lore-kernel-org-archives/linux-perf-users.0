Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4BF3C8C52;
	Thu, 18 Jun 2026 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781795781; cv=none; b=kDVbI3s4XhaF1wuy4DiX4KPftHKb5cSOMxn76G0zy/PSfpYxllYWygLh0oSw0NZkYA73FSa3qUOYAHANnem77z9Q05WMEGFzZNmNWDt2Y7ojHddPA7SADC0zrzssS6AOfDhNx52cQM0RdqBcCv1WtgjhDoYUBMMX678otUFsjlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781795781; c=relaxed/simple;
	bh=X8CGiYJnNWiXAD2rdjPt1ZMT2w3gnVkdfxrK3xH5pm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XZOQSShnxktv0JlJyE7MwFASpecM5mBnIAqk6AucMwWcqRLHpCD0fRoQAnlCsXJlykJpnVDi1bzukC14Fgz2E1J+E2ziev08A+VUOC/OSb7zS/0j2vNc5Iii53+nqlGCICuBovjmGKcSyBBbXkNgoI13EGSkipBPaWfHn+ZVyug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWOxxP76; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWOxxP76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D831F000E9;
	Thu, 18 Jun 2026 15:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781795780;
	bh=767V0DRP0lJ65KEigHvP/xCXUmyudxdchsstnmXOqEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mWOxxP761iMQ1y33uLQ2ETp2VPTd9Ffua0jSdY1sSBiJnENvyCFN8sPoQBJhIzicq
	 PkfEI8aCN19aNRCLB4F+2iG+HrOEOYYzs25M4Oyp1wPYE5V/ZlfBgx6ijYBUdxTay8
	 eNaJYJt04bmTqZ7VE9kMqpE4RVEF67ahzBGlBaCtfbWLXvzcu1bnnZ3qAYODfr/XlY
	 iG88e10fryrPRBeZOHQR91AqzDuR8g3yYS7G4ciYWQ+O4yDKb6skYVrmWb6GaEv01u
	 NOLDz6fqIQ/yVsD6/IH8AgMDoTVSOaNsaGRtIGQTc/X61HU9qHJbw+JzGYDD7AmWA9
	 v8h4NKfMCi34A==
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
Subject: [PATCH 2/7] dwarf_loader: Allow forcing the merge of CUs for solving inter CU tag references
Date: Thu, 18 Jun 2026 12:16:01 -0300
Message-ID: <20260618151606.82747-3-acme@kernel.org>
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

The Linux perf tool now includes some Rust code that then gets linked
into perf and comes with its DWARF that has tags referencing tags in
different CUs, and as the current DWARF loading algorithm uses
parallelization and recodes the big DWARF types (DWARF_off, usually
64-bit) into smaller ones as a step into converting to CTF (initially)
and later BTF, the resolution fails.

There is a case where this inter CU happens, LTO builds, and so there is
an alternative algorithm for that case, that serializes DWARF CU loading
and merges all the CUs into just one meta/mega-CU, which then has all
the types and thus doesn't have a problem with inter CU references, as
the recoding into smaller ids is done only after all CUs are loaded.

So while we don't refactor the loading in a way that allows for inter CU
while allowing parallelization, maybe by doing the recoding just at the
end of parallel loading, add minimal code to force this CU merging for
experimentation in such cases, getting back the regression test
prettify_perf.data.sh to work, making it force CU merging.

  $ pahole ~/bin/perf > unmerged.txt
  <Suppress lots of warnings when recoding DWARF types.>
  $ pahole --features=force_cu_merging ~/bin/perf > merged.txt
  $

With the current set of Rust types that are representable with the
pahole data structures and then pretty printed as if they were C we see
12 differences:

  $ diff -u unmerged.txt merged.txt | grep ^@@ | wc -l
  12
  $ diff -u unmerged.txt merged.txt | wc -l
  198

Of this kind, due to some types not being resolved as tags are
referencing tags in other CUs.

  $ diff -u unmerged.txt merged.txt | head
  --- unmerged.txt	2026-03-23 17:56:54.971785023 -0300
  +++ merged.txt	2026-03-23 17:56:59.826872178 -0300
  @@ -9643,10 +9643,11 @@
   	u64                        __0 __attribute__((__aligned__(8))); /*     0     8 */
   	struct Abbreviation        __1 __attribute__((__aligned__(8))); /*     8   112 */

  -	/* XXX last struct has 5 bytes of padding */
  +	/* XXX last struct has 16 bytes of padding, 1 hole */

   	/* size: 120, cachelines: 2, members: 2 */
  $

Now the pretty printing perf.data test case passes:

  ⬢ [acme@toolbx tests]$ ./prettify_perf.data.sh
  Pretty printing of files using DWARF type information.
  Test ./prettify_perf.data.sh passed
  ⬢ [acme@toolbx tests]$

This was implemented reusing the --btf_features mechanism that now can
be accessed as well via --features, as this is not strictly a BTF
feature but, as Alan Maguire suggested, it is desirable to ask for that
feature to be enabled when we know it is needed bug can't guarantee that
the available pahole version has the feature and not have it fail
because it doesn't implement --force_cu_merging, which the
--btf_features=force_cu_merging, now also avaialbe as
--features=force_cu_merging, allows as it ignores unknown features.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 dwarf_loader.c              |  2 +-
 dwarves.h                   |  1 +
 man-pages/pahole.1          | 17 +++++++++++++++--
 pahole.c                    | 11 ++++++++++-
 tests/prettify_perf.data.sh |  4 ++--
 5 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index f0833e8c44a944a8..54cc66748ef685fc 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -3945,7 +3945,7 @@ static int cus__load_module(struct cus *cus, struct conf_load *conf,
 		}
 	}
 
-	if (cus__merging_cu(dw, elf)) {
+	if (conf->force_cu_merging || cus__merging_cu(dw, elf)) {
 		res = cus__merge_and_process_cu(cus, conf, mod, dw, elf, filename,
 						build_id, build_id_len,
 						type_cu ? &type_dcu : NULL);
diff --git a/dwarves.h b/dwarves.h
index 4f3eac047f41edac..6595c16434966f09 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -106,6 +106,7 @@ struct conf_load {
 	bool			btf_gen_distilled_base;
 	bool			btf_attributes;
 	bool			true_signature;
+	bool			force_cu_merging;
 	uint8_t			hashtable_bits;
 	uint8_t			max_hashtable_bits;
 	uint16_t		kabi_prefix_len;
diff --git a/man-pages/pahole.1 b/man-pages/pahole.1
index b1be472de2b1e0c8..2fa82111c0f6305f 100644
--- a/man-pages/pahole.1
+++ b/man-pages/pahole.1
@@ -303,8 +303,9 @@ Generate BTF for functions with optimization-related suffixes (.isra, .constprop
 Allow using all the BTF features supported by pahole.
 
 .TP
-.B \-\-btf_features=FEATURE_LIST
-Encode BTF using the specified feature list, or specify 'default' for all standard features supported.  This option can be used as an alternative to using multiple BTF-related options, and 'default' represents the standard set of BTF features that are in use for kernel BTF generation, so is useful as a shortcut for testing the latest set of standard features.  However kernel builds will call out specific features rather than using 'default' to ensure that the desired features are enabled regardless of pahole version and associated 'default' set.  Supported standard features are
+.B \-\-features=FEATURE_LIST
+This is also available as \-\-btf_features=FEATURE_LIST, unknown features, like those added in newer versions of pahole, are ignored.
+BTF encoding configuration is the major user. Using 'default' will enable all standard features supported.  This option can be used as an alternative to using multiple BTF-related options, and 'default' represents the standard set of BTF features that are in use for kernel BTF generation, so is useful as a shortcut for testing the latest set of standard features.  However kernel builds will call out specific features rather than using 'default' to ensure that the desired features are enabled regardless of pahole version and associated 'default' set.  Supported standard features are
 
 .nf
 	encode_force       Ignore invalid symbols when encoding BTF; for example
@@ -344,6 +345,18 @@ Supported non-standard features (not enabled for 'default')
 	layout             Encode information about BTF kinds available at encoding     
 	                   time in layout section in BTF.
 
+Non-standard, non-BTF related features:
+
+	force_cu_merging   Force merging all CUs into one. Use when there are
+	                   references across CUs. This happens in some LTO cases
+	                   and was observed with Rust CUs, where types tags
+	                   (function parameters, abstract origins for inlines, etc)
+	                   reference types in another CU.
+	                   For LTO this is being autodetected and the merging of
+	                   cus is done automatically, but for the Rust case, and
+	                   maybe others this is needed with the current DWARF
+	                   loading algorithm.
+
 .fi
 
 So for example, specifying \-\-btf_encode=var,enum64 will result in a BTF encoding that (as well as encoding basic BTF information) will contain variables and enum64 values.
diff --git a/pahole.c b/pahole.c
index 033baedcc602cc75..28d8f8832773520b 100644
--- a/pahole.c
+++ b/pahole.c
@@ -1153,6 +1153,7 @@ ARGP_PROGRAM_VERSION_HOOK_DEF = dwarves_print_version;
 #define ARG_padding		   348
 #define ARGP_with_embedded_flexible_array 349
 #define ARGP_btf_attributes	   350
+#define ARGP_features		   351
 
 /* --btf_features=feature1[,feature2,..] allows us to specify
  * a list of requested BTF features or "default" to enable all default
@@ -1240,7 +1241,8 @@ struct btf_feature {
 	BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
 				      attributes_check),
 	BTF_NON_DEFAULT_FEATURE(true_signature, true_signature, false),
-	BTF_NON_DEFAULT_FEATURE_CHECK(layout, btf_gen_layout, false, layout_check)
+	BTF_NON_DEFAULT_FEATURE_CHECK(layout, btf_gen_layout, false, layout_check),
+	BTF_NON_DEFAULT_FEATURE(force_cu_merging, force_cu_merging, false),
 };
 
 #define BTF_MAX_FEATURE_STR	1024
@@ -1798,6 +1800,12 @@ static const struct argp_option pahole__options[] = {
 		.arg = "FEATURE_LIST",
 		.doc = "Specify supported BTF features in FEATURE_LIST or 'default' for default set of supported features. See the pahole manual page for the list of supported, default features."
 	},
+	{
+		.name = "features",
+		.key = ARGP_features,
+		.arg = "FEATURE_LIST",
+		.doc = "Specify supported features in FEATURE_LIST or 'default' for default set of supported features. See the pahole manual page for the list of supported, default features."
+	},
 	{
 		.name = "supported_btf_features",
 		.key = ARGP_supported_btf_features,
@@ -2012,6 +2020,7 @@ static error_t pahole__options_parser(int key, char *arg,
 		conf_load.reproducible_build = true;	break;
 	case ARGP_running_kernel_vmlinux:
 		show_running_kernel_vmlinux = true;	break;
+	case ARGP_features:
 	case ARGP_btf_features:
 		parse_btf_features(arg, false);		break;
 	case ARGP_supported_btf_features:
diff --git a/tests/prettify_perf.data.sh b/tests/prettify_perf.data.sh
index 1fae95154d710aae..384c250ff4e01a4c 100755
--- a/tests/prettify_perf.data.sh
+++ b/tests/prettify_perf.data.sh
@@ -25,7 +25,7 @@ fi
 perf_lacks_type_info() {
 	local type_keyword=$1
 	local type_name=$2
-	if ! pahole -C $type_name $perf | grep -q "^$type_keyword $type_name {"; then
+	if ! pahole --features=force_cu_merging -C $type_name $perf | grep -q "^$type_keyword $type_name {"; then
 		info_log "skip: $perf doesn't have '$type_keyword $type_name' type info"
 		test_skip
 	fi
@@ -41,7 +41,7 @@ $perf record --quiet -o $perf_data sleep 0.00001
 
 number_of_filtered_perf_record_metadata() {
 	local metadata_record=$1
-	local count=$(pahole -F dwarf -V $perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C "perf_event_header(sizeof,type,type_enum=perf_event_type+perf_user_event_type,filter=type==PERF_RECORD_$metadata_record)" --prettify $perf_data | grep ".type = PERF_RECORD_$metadata_record," | wc -l)
+	local count=$(pahole --features=force_cu_merging -F dwarf -V $perf --header=perf_file_header --seek_bytes '$header.data.offset' --size_bytes='$header.data.size' -C "perf_event_header(sizeof,type,type_enum=perf_event_type+perf_user_event_type,filter=type==PERF_RECORD_$metadata_record)" --prettify $perf_data | grep ".type = PERF_RECORD_$metadata_record," | wc -l)
 	echo "$count"
 }
 
-- 
2.54.0

