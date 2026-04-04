Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch [109.224.244.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480F22236F7
	for <linux-perf-users@vger.kernel.org>; Sat,  4 Apr 2026 01:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775265425; cv=none; b=R+VY2Z0b/2PI77DuB/UHfyDJHcCAyK5a+27D23S9hOCW49hHJxpG/93GgezhlJ/BJ7PPwtRQDAfcCJ6KfGulq8hjnz1vIyPaQBPvZfymvn/WN1xv6Z68Jmtk9OeFvQqe4j/fTjkDxp3xb8Auq5ax4MLfTJtrHd4sWz+fct4qZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775265425; c=relaxed/simple;
	bh=X6tmwAVN6joHV3Ll6UrpMWahPmUQeJwIus4lac2iDw0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mL2M6U2F0UKNbbi0JobusMYI8bSlPK/pVJ9omW49PA04n1LM3foZIQuWua3Obd+DBp9AThpEf+KvxlX1cIox1uKEqHxoQj0ZHxFkmLbR4BZZLyahRFjvgxJVcWSLnSlHEnR1wwhC++pEOIcrBEx+GMXZvvOnAE8cyBq1YDY9Jzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=j1aH+XrY; arc=none smtp.client-ip=109.224.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="j1aH+XrY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1775265418; x=1775524618;
	bh=cqjZ0j1WNy0RUPh3irk+7X8G8Olz0+jtc8Phy0j/yQQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=j1aH+XrYJHkz+GiOqnfw41q/3w1NGHl+lG19KA4pyOdGYYOd7tKpKmPp0UhvCEpZE
	 VFK92uyUvDIs4l62XXogsvgS2MkLPh3TfG6Q8hXDaKA3k56XFIFpQ50nrSOqqV+orQ
	 JGiqe40gMSn3ORffAtsJIVWdXBQFEkwNp/XUdnQPcfZLfK1lEXCKJIgjSBsF2gMD4Z
	 ydqUakVXOms2GZioP3sGC4zFfdmVr3BMPQgR3MrKemIy1W1BydwZe8+1dA3q6XtGoe
	 SzUlr2Y5rRhjICyfeMyBOMCIjhXqJQNfRosB72IZ4A8NGqi5yMJQ5aDrQlyqKJLuHQ
	 EI5OGwzO6n/4w==
Date: Sat, 04 Apr 2026 01:16:56 +0000
To: namhyung@kernel.org
From: Ricky Ringler <ricky.ringler@proton.me>
Cc: irogers@google.com, mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Ricky Ringler <ricky.ringler@proton.me>
Subject: [PATCH v6] perf utilities: cln_size header
Message-ID: <20260404011313.51901-4-ricky.ringler@proton.me>
In-Reply-To: <adBbXHuhs6TlwJre@google.com>
References: <aaeKBOolC3AyHAFa@google.com> <20260308172037.123654-1-ricky.ringler@proton.me> <CAP-5=fVk22oOxLSN-2_MioJ3RKUpQwD2TWK9sA=WcegUc_dj1w@mail.gmail.com> <20260321204145.26359-1-ricky.ringler@proton.me> <acW2j7hki-u50YYz@google.com> <20260328200442.134489-1-ricky.ringler@proton.me> <actrosC-vqhjMA-A@google.com> <20260403220758.41790-1-ricky.ringler@proton.me> <adBbXHuhs6TlwJre@google.com>
Feedback-ID: 171348601:user:proton
X-Pm-Message-ID: 505a1294c55885ccbee936adfba18aa72f5c2f29
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Forgive me for wasting your time with my last message...
I switched work machines and attached the wrong patch file.

---

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
 tools/perf/util/header.c    | 31 ++++++++++++++++++++++++++++++
 tools/perf/util/header.h    |  3 +++
 tools/perf/util/sort.c      | 38 ++++++++++++++++++++++++++-----------
 5 files changed, 63 insertions(+), 11 deletions(-)

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
index 9142a8ba4019..2a2c64b1a384 100644
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
@@ -1304,6 +1305,20 @@ static int write_cache(struct feat_fd *ff,
 =09return ret;
 }
=20
+static int write_cln_size(struct feat_fd *ff,
+=09=09       struct evlist *evlist __maybe_unused)
+{
+=09int cln_size =3D cacheline_size();
+
+
+=09if (!cln_size)
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
@@ -2261,6 +2276,11 @@ static void print_cache(struct feat_fd *ff, FILE *fp=
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
@@ -3154,6 +3174,16 @@ static int process_cache(struct feat_fd *ff, void *d=
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
@@ -3763,6 +3793,7 @@ const struct perf_header_feature_ops feat_ops[HEADER_=
LAST_FEATURE] =3D {
 =09FEAT_OPR(PMU_CAPS,=09pmu_caps,=09false),
 =09FEAT_OPR(CPU_DOMAIN_INFO,=09cpu_domain_info,=09true),
 =09FEAT_OPR(E_MACHINE,=09e_machine,=09false),
+=09FEAT_OPR(CLN_SIZE,=09cln_size,=09false),
 };
=20
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index cc40ac796f52..8429e856fd7c 100644
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
@@ -202,6 +203,8 @@ int write_padded(struct feat_fd *fd, const void *bf,
=20
 int build_caches_for_cpu(u32 cpu, struct cpu_cache_level caches[], u32 *cn=
tp);
=20
+#define DEFAULT_CACHELINE_SIZE 64
+
 /*
  * arch specific callback
  */
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 42d5cd7ef4e2..50eb58837b10 100644
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
@@ -2474,7 +2475,27 @@ struct sort_entry sort_type_offset =3D {
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
+=09if (!ret || ret < 1)
+=09=09ret =3D DEFAULT_CACHELINE_SIZE; // avoid div/0 later
+
+=09return ret;
+}
=20
 static int64_t
 sort__typecln_sort(struct hist_entry *left, struct hist_entry *right)
@@ -2482,11 +2503,9 @@ sort__typecln_sort(struct hist_entry *left, struct h=
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
@@ -2502,8 +2521,8 @@ sort__typecln_sort(struct hist_entry *left, struct hi=
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
@@ -2511,10 +2530,7 @@ static int hist_entry__typecln_snprintf(struct hist_=
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


