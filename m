Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F59F2BD01B
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Apr 2026 22:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775254098; cv=none; b=tXcfGgI2Uu5vHHs3EBi46xXKh9F2K+Sjz55v0GlYSiJEo0M6N95GjgsaoUI3Xqc/YQmVPNPb932WSMjWK1Vs/EDHFKAHf86CdujCk9qIDIJwnz3i0JvBknR0LeovmpTgLEiIiMKfyWmMZeleO5tp2aXGxCDz+p3R1oVUwgYli4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775254098; c=relaxed/simple;
	bh=PEU+wPAm+UGdX54WckdlOS4SHFAGh8ij8Je0az1nS80=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLJErsGrJJ4NPyESbqeb91JMYc+hPnm42y9VQdRiNCOY2QC++TIft6gJgDj938ZLw0LFW60Q5K1DbzeCYR6fuJ14g7YnvCKQHLaYUYEDw3ObQ0ddBGBX1C/WI4CH8G49rJ1wiyzWLWvTqIr4WwuokOJhV9JNuBF3oOmKc5xghcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=L2kmUWvY; arc=none smtp.client-ip=109.224.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="L2kmUWvY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=yquvf57vv5fr7gq3yebfisolf4.protonmail; t=1775254090; x=1775513290;
	bh=mzeiOrpB/7evNVL9iJyGHUJYjfa02lEeWY/oPqk1NH8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=L2kmUWvYZ+wyuXt6HdG4VhAue/v1C9j0vOk3D1ri9LVxnP6K5WjdtjkCLDmgw/Si2
	 bqLaZkgyUK4oJDx2i0P0VSGMIbQNsn32EuUrApaihSV1iHs9aC5AQxXnKPL5xQlmDC
	 S4rCfCd3151a0XHB5Ood8ZeKlAommHYdN5eZiiEFbxQ5JRQuOQEndmjO8d+d4MSHTA
	 3DXj+BHBt9gThWMbnQIt6zbW7Rc+wCWmAB7cfJimdsRf1bEnxEmfYoykweOxM2vsab
	 yLJnHP3nMeoFSV1t5Emqk9VsKiY7A6UWmX7XPmZd5P3mWw1BLpWymLFOnE6UqSV4tz
	 dRwWOUKkAHvKw==
Date: Fri, 03 Apr 2026 22:08:06 +0000
To: namhyung@kernel.org
From: Ricky Ringler <ricky.ringler@proton.me>
Cc: irogers@google.com, mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ricky Ringler <ricky.ringler@proton.me>
Subject: [PATCH v6] perf utilities: cln_size header
Message-ID: <20260403220758.41790-1-ricky.ringler@proton.me>
In-Reply-To: <actrosC-vqhjMA-A@google.com>
References: <20260214040659.168769-2-ricky.ringler@proton.me> <aaeKBOolC3AyHAFa@google.com> <20260305235655.40779-1-ricky.ringler@proton.me> <THyJLu3kRy_7q7V6-XpKu2hIZsSzkadNwnZ6YIOUSSTS2if2u3OWv6ROm_MtvBWVQVOJ03FVWw0POxzhU0LpeSBhoKSxTwKVV-JhZFJNCvg=@proton.me> <20260308172037.123654-1-ricky.ringler@proton.me> <CAP-5=fVk22oOxLSN-2_MioJ3RKUpQwD2TWK9sA=WcegUc_dj1w@mail.gmail.com> <20260321204145.26359-1-ricky.ringler@proton.me> <acW2j7hki-u50YYz@google.com> <20260328200442.134489-1-ricky.ringler@proton.me> <actrosC-vqhjMA-A@google.com>
Feedback-ID: 171348601:user:proton
X-Pm-Message-ID: 5b38894d5c9fd89bec08897b4fcedd666f82016c
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Store cacheline size during perf record in header, so
that cacheline size can be used for other features, like
sort.

V6: Namhyung feedback and tests
V5: Namhyung feedback
V4: Ian feedback
V3: Rebase off perf-tools-next round two
V2: Rebase off perf-tools-next

Follow-up patch from message ID "aYZiQk6Uftzlb_JV@x1"

Testing:
- Built perf
- Ran record + report with feat enabled
- Ran record + report with feat disabled

Testing example with feat enabled:
$ perf record ./Example
$ perf report --header-only | grep -C 3 cacheline
CPU_DOMAIN_INFO info available, use -I to display
e_machine : 62
e_flags : 0
cacheline size: 64
missing features: TRACING_DATA BUILD_ID BRANCH_STACK GROUP_DESC AUXTRACE \
STAT CLOCKID DIR_FORMAT COMPRESSED CLOCK_DATA
=3D=3D=3D=3D=3D=3D=3D=3D

Signed-off-by: Ricky Ringler <ricky.ringler@proton.me>
---
 tools/perf/builtin-inject.c |  1 +
 tools/perf/util/env.h       |  1 +
 tools/perf/util/header.c    | 33 +++++++++++++++++++++++++++++
 tools/perf/util/header.h    |  1 +
 tools/perf/util/sort.c      | 41 +++++++++++++++++++++++++++----------
 5 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 5b29f4296861..11ac7c8c4be3 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -2134,6 +2134,7 @@ static bool keep_feat(struct perf_inject *inject, int=
 feat)
 =09case HEADER_HYBRID_TOPOLOGY:
 =09case HEADER_PMU_CAPS:
 =09case HEADER_CPU_DOMAIN_INFO:
+=09case HEADER_CLN_SIZE:
 =09=09return true;
 =09/* Information that can be updated */
 =09case HEADER_BUILD_ID:
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index a4501cbca375..c7052ac1f856 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -112,6 +112,7 @@ struct perf_env {
 =09struct cpu_cache_level=09*caches;
 =09struct cpu_domain_map=09**cpu_domain;
 =09int=09=09=09 caches_cnt;
+=09unsigned int=09=09cln_size;
 =09u32=09=09=09comp_ratio;
 =09u32=09=09=09comp_ver;
 =09u32=09=09=09comp_type;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 9142a8ba4019..4d852bd4ca9a 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -54,6 +54,7 @@
 #include "bpf-event.h"
 #include "bpf-utils.h"
 #include "clockid.h"
+#include "cacheline.h"
=20
 #include <linux/ctype.h>
 #include <internal/lib.h>
@@ -1304,6 +1305,22 @@ static int write_cache(struct feat_fd *ff,
 =09return ret;
 }
=20
+#define DEFAULT_CACHELINE_SIZE =3D 64
+
+static int write_cln_size(struct feat_fd *ff,
+=09=09       struct evlist *evlist __maybe_unused)
+{
+=09int cln_size =3D cacheline_size();
+
+
+=09if(!cln_size)
+=09=09cln_size =3D DEFAULT_CACHELINE_SIZE;
+
+=09ff->ph->env.cln_size =3D cln_size;
+
+=09return do_write(ff, &cln_size, sizeof(cln_size));
+}
+
 static int write_stat(struct feat_fd *ff __maybe_unused,
 =09=09      struct evlist *evlist __maybe_unused)
 {
@@ -2261,6 +2278,11 @@ static void print_cache(struct feat_fd *ff, FILE *fp=
 __maybe_unused)
 =09}
 }
=20
+static void print_cln_size(struct feat_fd *ff, FILE *fp)
+{
+=09fprintf(fp, "# cacheline size: %u\n", ff->ph->env.cln_size);
+}
+
 static void print_compressed(struct feat_fd *ff, FILE *fp)
 {
 =09fprintf(fp, "# compressed : %s, level =3D %d, ratio =3D %d\n",
@@ -3154,6 +3176,16 @@ static int process_cache(struct feat_fd *ff, void *d=
ata __maybe_unused)
 =09return -1;
 }
=20
+static int process_cln_size(struct feat_fd *ff, void *data __maybe_unused)
+{
+=09struct perf_env *env =3D &ff->ph->env;
+
+=09if (do_read_u32(ff, &env->cln_size))
+=09=09return -1;
+
+=09return 0;
+}
+
 static int process_sample_time(struct feat_fd *ff, void *data __maybe_unus=
ed)
 {
 =09struct perf_session *session;
@@ -3763,6 +3795,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_=
LAST_FEATURE] =3D {
 =09FEAT_OPR(PMU_CAPS,=09pmu_caps,=09false),
 =09FEAT_OPR(CPU_DOMAIN_INFO,=09cpu_domain_info,=09true),
 =09FEAT_OPR(E_MACHINE,=09e_machine,=09false),
+=09FEAT_OPR(CLN_SIZE,=09cln_size,=09false),
 };
=20
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index cc40ac796f52..be315040727f 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -55,6 +55,7 @@ enum {
 =09HEADER_PMU_CAPS,
 =09HEADER_CPU_DOMAIN_INFO,
 =09HEADER_E_MACHINE,
+=09HEADER_CLN_SIZE,
 =09HEADER_LAST_FEATURE,
 =09HEADER_FEAT_BITS=09=3D 256,
 };
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 42d5cd7ef4e2..5f617cf03d5d 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -30,6 +30,7 @@
 #include "time-utils.h"
 #include "cgroup.h"
 #include "machine.h"
+#include "session.h"
 #include "trace-event.h"
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -2474,7 +2475,30 @@ struct sort_entry sort_type_offset =3D {
=20
 /* --sort typecln */
=20
-#define DEFAULT_CACHELINE_SIZE 64
+static int
+hist_entry__cln_size(struct hist_entry *he)
+{
+=09int ret =3D 0;
+
+=09if (he && he->hists) {
+=09=09struct evsel *evsel =3D hists_to_evsel(he->hists);
+
+
+=09=09if (evsel) {
+=09=09=09struct perf_session *session =3D evsel__session(evsel);
+
+=09=09=09ret =3D session->header.env.cln_size;
+=09=09}
+=09}
+
+=09if (!ret || ret < 1) {
+=09=09int default_cacheline_size =3D 64; // avoid div/0 later
+
+=09=09ret =3D default_cacheline_size;
+=09}
+
+=09return ret;
+}
=20
 static int64_t
 sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
@@ -2482,11 +2506,9 @@ sort__typecln_sort(struct hist_entry *left, struct h=
ist_entry *right)
 =09struct annotated_data_type *left_type =3D left->mem_type;
 =09struct annotated_data_type *right_type =3D right->mem_type;
 =09int64_t left_cln, right_cln;
+=09int64_t cln_size_left =3D hist_entry__cln_size(left);
+=09int64_t cln_size_right =3D hist_entry__cln_size(right);
 =09int64_t ret;
-=09int cln_size =3D cacheline_size();
-
-=09if (cln_size =3D=3D 0)
-=09=09cln_size =3D DEFAULT_CACHELINE_SIZE;
=20
 =09if (!left_type) {
 =09=09sort__type_init(left);
@@ -2502,8 +2524,8 @@ sort__typecln_sort(struct hist_entry *left, struct hi=
st_entry *right)
 =09if (ret)
 =09=09return ret;
=20
-=09left_cln =3D left->mem_type_off / cln_size;
-=09right_cln =3D right->mem_type_off / cln_size;
+=09left_cln =3D left->mem_type_off / cln_size_left;
+=09right_cln =3D right->mem_type_off / cln_size_right;
 =09return left_cln - right_cln;
 }
=20
@@ -2511,10 +2533,7 @@ static int hist_entry__typecln_snprintf(struct hist_=
entry *he, char *bf,
 =09=09=09=09     size_t size, unsigned int width __maybe_unused)
 {
 =09struct annotated_data_type *he_type =3D he->mem_type;
-=09int cln_size =3D cacheline_size();
-
-=09if (cln_size =3D=3D 0)
-=09=09cln_size =3D DEFAULT_CACHELINE_SIZE;
+=09int cln_size =3D hist_entry__cln_size(he);
=20
 =09return repsep_snprintf(bf, size, "%s: cache-line %d", he_type->self.typ=
e_name,
 =09=09=09       he->mem_type_off / cln_size);
--=20
2.53.0


