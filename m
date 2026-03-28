Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E144032720D;
	Sat, 28 Mar 2026 20:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774728308; cv=none; b=a2MfWZKhi3b/O5WEq4B05vDWtbANLg4iE72DQza1NefslvZPpvQxCiDqoTasySOiv6GYlrUfCZRBGxTadvO+6lKYAg0ca3W3ShVdkBExLU54wk2Zz/DDzeHYVFzqZ1WGuj+RkJ6xvovBbsbBU8rz9eWvaXj/iI7lvdDPn/7ES8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774728308; c=relaxed/simple;
	bh=cHgXijMZVlGPBfwbcnUY/SIfD8bN3S1pTNfSWGhPv5I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qNNqeTDlsrLUioicoT1O7h6mRCJ6J3l9BRMP+XDvNPEPauPUxlALN5io6NO+tK9qpWewP+bkUIDjJlB5kjF316Izdm1aaqBPPEYXlQWikDAxG6w02mjsEYr42kUaKPCak2syhrdpqhEWOscn8TtfEk0HRxvxRkVQYNqXYXZzlPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=W5q6dqwf; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="W5q6dqwf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1774728297; x=1774987497;
	bh=o0uEth+v09+G4LVAnrdbt6+QAzoQB2c/e72JLtyM8Oc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W5q6dqwfzB2NQcjZBR4Fr5jjmc6bvR/FdqhNf7qhxlAzXlCPbeGxyv12qBRnqW/0F
	 EQXWyZJqdCFfs9CbKIqbMxwV06xi+p2FYVlTgdSutYNYRqm8DHbd25ZlXa2i4xV5xa
	 oWdjg/4mVwDApoHFcSex8c0n8UyME1JtHo6q1RSL1c+KEmbILgxXc6tHqf7zqZ54Oz
	 +AAcp8IK8ICxSimx0544f++xgSCIeaHsGPvsn5b5Dx17xIFw0fqEm4y/Hcz4ma0Fny
	 oFEQeQPBmB7PQIx61v2J/ruJXVodqqhE8+dVBSB9U7feVqZMCTjI58/xAqlnKuzgbO
	 nVuv3W80Z8jNg==
Date: Sat, 28 Mar 2026 20:04:52 +0000
To: namhyung@kernel.org
From: Ricky Ringler <ricky.ringler@proton.me>
Cc: irogers@google.com, mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ricky Ringler <ricky.ringler@proton.me>
Subject: [PATCH v5] perf utilities: cln_size header
Message-ID: <20260328200442.134489-1-ricky.ringler@proton.me>
In-Reply-To: <acW2j7hki-u50YYz@google.com>
References: <20260214040659.168769-2-ricky.ringler@proton.me> <aaeKBOolC3AyHAFa@google.com> <20260305235655.40779-1-ricky.ringler@proton.me> <THyJLu3kRy_7q7V6-XpKu2hIZsSzkadNwnZ6YIOUSSTS2if2u3OWv6ROm_MtvBWVQVOJ03FVWw0POxzhU0LpeSBhoKSxTwKVV-JhZFJNCvg=@proton.me> <20260308172037.123654-1-ricky.ringler@proton.me> <CAP-5=fVk22oOxLSN-2_MioJ3RKUpQwD2TWK9sA=WcegUc_dj1w@mail.gmail.com> <20260321204145.26359-1-ricky.ringler@proton.me> <acW2j7hki-u50YYz@google.com>
Feedback-ID: 171348601:user:proton
X-Pm-Message-ID: 69b7ab33184e0c917f34e2eec806b0d0195265e0
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

V5: Namhyung feedback
V4: Ian feedback
V3: Rebase off perf-tools-next round two
V2: Rebase off perf-tools-next

Follow-up patch from message ID "aYZiQk6Uftzlb_JV@x1"

Testing:
- Built perf
- Ran record + report with feat enabled
- Ran record + report with feat disabled

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


