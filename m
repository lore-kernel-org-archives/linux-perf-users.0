Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF83AC0F5
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786994000; cv=pass; b=Z9oWa4Yu03cKRuMv14r5/rF2J2/EuytUdr7LU59nnb0KZ3a5UpqRSTsMCEww/h1oruTaymCjMUoNmd59Ii1DmjHQT34EtdX3MFZvMIEMOE3MM29qOz9tv9X1U8uGzaeV8Ove9p6OLoVB5X8gQBB5CZyadv1vpQWPZEEXcaMFrN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786994000; c=relaxed/simple;
	bh=5Fqi6eT0e9/OE0etX2xfW13U38y48HYhtX/oiw0n9kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjvtdRTREAqlXfXP+osaxRmxy1DaC+UBNzD3IcsA+vyKdei20wY5oZy8Njl16qOJsT7MVsgWrRNt51rOSW/mYt2P8X+gww06tblSf+lFdiucnQ/FH9O3FtX4X94A+Q6hSb6bpx9CWpjqYluz5+fKeb6Neiv/hrrmzM+SdNa26Wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MRl5x83+; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MRl5x83+"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c10e86e52so39091cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 12:13:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786993997; cv=none;
        d=google.com; s=arc-20260327;
        b=sl+2PMmog+zEAoxK7ae2aGH97d0iLcqhxVMD5oDraS9Ndm57M8ZA+36DLAtccs++ix
         /fSedR+i+CV34LXSBeWKJKQy3rR+ZH3WfeM1resLzWZVFQQutzz/tO8bSXpZcV0CVBYn
         Qwsveqg1Xqtc1CMXaWi0hKzl33SAXTKrTjKWlTGWBbfGLf/RkeZb7ENfdPIOkS6Iif2o
         6wZKU3DoGsVqkRvLRmn3R/uVb9EVSM6LF+xHfOYnLLlTuC8TCgcGMQBnUKTlYu+nbig2
         3TLP9jBzSXAfnDWpf0kalDKAv6L2YXwuvs1Q0OmqjVBBqqJsdzsOAqIve/lhxBU6T68k
         XnVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FzuiThJU3cToysD2v6va8Ptkbh6YOkAWmgOp6H2AdUQ=;
        fh=/iqiVvNprc9uz0BePktfL/0sIQ0gwu8v2G2JcmdXbJg=;
        b=ZsWxha9kIyd8e1mGpe0t3sLjXmInsJ9pqQZ2gGGLFpds46lB3bDMMAVNfYPtQuZjUp
         PaumoX5GQuAs9ugFg3qkDoOkhj5JxsyiSEZCpnPLdlL2YSd/wp9TQpbcmfnuvVoo4Btz
         Kky1YUbU/o8xZmGD2SVd+mdB1WIna1RKa5knuCeeqMrg2XF39mnL/SaSyW6JjWM8C/7+
         0ezwreGvknAmv6b0l1hOqj02oj3PEJbwCDzYHJ17+R4NfO1cJSJ1ACSwtTVKoIoYAoVi
         3YMb8+D3wOtBccgrPMqvl0IRjE3l5FiXeqimZ/TxGy1g/2ZSLw8nMGjneHY6v4QSUzIt
         qMqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786993997; x=1787598797; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FzuiThJU3cToysD2v6va8Ptkbh6YOkAWmgOp6H2AdUQ=;
        b=MRl5x83+PDLelW1jgWpEAcZXUsyBSFLpnUFr/t+Pmw7mfDAsjeVvBvHRVjFSPZPAvC
         U6/mnYxjW3t92v4ay7Dd1XUENcDz6Hd477YshcF7Fut29w7chpg8s7awWe5ZbKpG/+Xs
         +VGo16V1Gf9P2YRjmXr93dpVuAzYGSOFWvCXFBo3UTEgvA2J5fcbk17KsBOdWg9zR97j
         MHl12UpUYq1m1vbHdPjW0OSrGEkRDnZr1FGsCDZoxGXZL8Zo1nqMcw2D8PfLPjtPVoOF
         /XvBwm0M05cGrn5J1t1A4beRwk48T7eKvUJ4lQ0JsY8aweZxGbENMWKRZ60jI6U2pciL
         aMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786993997; x=1787598797;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FzuiThJU3cToysD2v6va8Ptkbh6YOkAWmgOp6H2AdUQ=;
        b=V/jFW8oVEcXlZls4/UsPmFDea5fdQSIHNYKJw3WYdjyIkde0pi9wz3sIWEy4Rp5QOM
         4M2iafJBU+nYXVeLAPFJrGWdmET8WV85rRyx0sTilSu4uqipFkmQyFo4NHN3nF3TJClW
         AuMm5HIqoMTBJZ+b5MPtDp/1wG5A6AJLY5AXHrS3D2mMtthcSP63gA9GOIUXkI63e3d6
         ld73ar5bZkqXy7/k27yD32wnO4KvlLyRWga+TggZlLk63/mNupkO9AhKuWkxYNkE27z7
         RzTBZ63XLOrznP/CHtk40Cwj3b2VxSKYfgDbVfhiPaCAGtsRbmYZrKLO60vTrx4uFrpT
         t/bw==
X-Forwarded-Encrypted: i=1; AHgh+RrL46pgsZX/PAKOvj+Itz7G/l2JBTyjRRSULN5CsBviw1NR01QYtrf7gzK89smrWVpSZcB6p0rC4ipISOECTuMm@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6JXQXTPhciR8y5Rq0Mwk+lyNwinCT3yR50mPNKNg/LaXrlUpw
	3z7Lgz0wupWhwHIKcZEbOB5MgTOkFfZeTyvUKjcLVOzorhZVh41J0WshzyN+1PtwgF35RYqZlVz
	6wU8DUVqc4/HqBVP0iXi+KHI6wiI8+TtTFvtu67bo
X-Gm-Gg: AR+sD135iaQBF59nLxFR+o4XvIIdvXyRZga4EIBiRll6O6B4LIFh0XrtonVLqXYET6o
	ufIAHfLoUpcGwBKCsfRUPKe5a/smyOWhWoV2+L27jDUnXztpD/6bMSNL+zUpi1Vyc0S53eGhYG+
	etVwWm6o0zR1iC67qETP3w4fn9HTS21X+JI1DYglAfV8kH4ymLmfhtr9GoOlAErxlRfqYm1oGD5
	GDtD92rR9+mWrVfDyZlOfTpZ/KISjmgocmxDyVliArBBH+VoLVVdaMlL6JjWyaEFir+Fv4ZqLNL
	n5/Dn6A8FSVjpe+kYfRpJAlVRTMvUvp9qskOf0qCGPUFFFb7enP8L0+mlolZS1IoAZQoFgHTUQo
	=
X-Received: by 2002:ac8:7dcc:0:b0:519:b655:235 with SMTP id
 d75a77b69052e-52dc0aef867mr2750821cf.3.1786993995766; Mon, 17 Aug 2026
 12:13:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817-rdpmc-detection-logic-v4-1-c22074578f6a@linaro.org>
In-Reply-To: <20260817-rdpmc-detection-logic-v4-1-c22074578f6a@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 12:13:04 -0700
X-Gm-Features: AcwNN1WnrkceMG5QBHmSxdpZXirR9qQDTUWT-jKQLYzFodQeyPC2xxLmattmfmA
Message-ID: <CAP-5=fWw6-NsAOjSUSNFgnA0vNg1pbE=Yf=QwF54y97WTdjXyQ@mail.gmail.com>
Subject: Re: [PATCH v4] perf tests: mmap-basic: fix user rdpmc detection logic
To: James Clark <james.clark@linaro.org>
Cc: Michael Petlan <mpetlan@redhat.com>, Qiao Zhao <qzhao@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Leo Yan <leo.yan@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 8:54=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> From: Qiao Zhao <qzhao@redhat.com>
>
> RISC-V and Arm control userspace counter access through
> /proc/sys/kernel/perf_user_access. Add that as a fallback to
> set_user_read() so the test can test both the enabled and disabled
> states on those platforms. RISC-V also uses a '2' value rather than just
> 0 or 1 so add support for restoring arbitrary values.
>
> On Arm, cap_user_rdpmc will always be set when requested, even if the
> global setting is disabled. This is so that the feature can be enabled
> or revoked while events are live. Skip checking it on Arm for the
> "expected disabled" case, otherwise the test will fail.
>
> Add comments, more meaningful variable names and improve the error
> messages so that it's clearer what this part of the test is doing.
>
> Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> [Test pc->index, fix bugs in set_user_read(), and simplify commit msg]
> Assisted-by: Codex:GPT-5.6
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> I'm sending this to fix the comments that I left on the "V3 resend"
> because I don't think Qiao sent a V4 and it's been quite a while.
>
> There were also some unreported bugs that I found during testing.
>
> Changes in V4:
>  - Don't remove pc->index check. Without it Perf can silently fall back
>    to the read() syscall and the test is useless.
>  - Test the 'expected disabled' case for Arm in an ifdef to workaround
>    platform differences.
>  - lseek() before writing to perf_user_access otherwise it's ignored.
>  - Support restoring arbitrary values to perf_user_access because RISC-V
>    uses '2' for legacy mode.

What does that mean? Should there be corresponding "legacy" support in libp=
erf?

>  - Rename rdpmc_supported to rdpmc_expected as this is what the test
>    expects, not what the system does.

Can you explain the distinction here? The test expects that if
userspace reading is enabled, it should be supported. Imo this makes a
line like:
```
if (rdpmc_supported && counts.val =3D=3D 0) {
```
easy to read. The same line with rdpmc_expected, well I need to then
go and figure out what expected should mean and it seems to just mean
supported, so the code was more readable before.

>  - Label pc->index as rdpmc_event_active for clarity.
>  - Add comments and simplify the commit message.
> ---
>  tools/perf/tests/mmap-basic.c | 137 ++++++++++++++++++++++++++++++------=
------
>  1 file changed, 98 insertions(+), 39 deletions(-)
>
> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.=
c
> index 5cec7644952c..4433a5df3d77 100644
> --- a/tools/perf/tests/mmap-basic.c
> +++ b/tools/perf/tests/mmap-basic.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <errno.h>
>  #include <inttypes.h>
> +#include <limits.h>
>  #include <stdlib.h>
>
>  #include <fcntl.h>
> @@ -182,47 +183,77 @@ static int test__basic_mmap(struct test_suite *test=
 __maybe_unused, int subtest
>  }
>
>  enum user_read_state {
> -       USER_READ_ENABLED,
> -       USER_READ_DISABLED,
> -       USER_READ_UNKNOWN,
> +       USER_READ_UNKNOWN =3D -1,
> +       USER_READ_DISABLED =3D 0,
> +       USER_READ_ENABLED =3D 1,
>  };
>
> -static enum user_read_state set_user_read(struct perf_pmu *pmu, enum use=
r_read_state enabled)
> +static int set_user_read_fd(int fd, int enabled)

Why change this to an int rather than adding "legacy" to the
user_read_state enum? An int gives far more potential values than the
enum and so appears inherently less intention-revealing.

>  {
> -       char buf[2] =3D {0, '\n'};
> +       char buf[32], *endptr;
> +       long value;
>         ssize_t len;
> -       int events_fd, rdpmc_fd;
> -       enum user_read_state old_user_read =3D USER_READ_UNKNOWN;
> +       int old_user_read;
>
> -       if (enabled =3D=3D USER_READ_UNKNOWN)
> +       len =3D read(fd, buf, sizeof(buf) - 1);
> +       if (len <=3D 0) {
> +               pr_debug("%s read failed\n", __func__);
>                 return USER_READ_UNKNOWN;
> +       }
> +       buf[len] =3D '\0';
>
> -       events_fd =3D perf_pmu__event_source_devices_fd();
> -       if (events_fd < 0)
> +       errno =3D 0;
> +       value =3D strtol(buf, &endptr, 10);
> +       if (errno || endptr =3D=3D buf || value < 0 || value > INT_MAX) {

Given we're range checking the read value, can the upper bound be "> 2" ?

> +               pr_debug("%s invalid value: %s\n", __func__, buf);
>                 return USER_READ_UNKNOWN;
> +       }
> +       old_user_read =3D value;
>
> -       rdpmc_fd =3D perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc",=
 O_RDWR);
> -       if (rdpmc_fd < 0) {
> -               close(events_fd);
> -               return USER_READ_UNKNOWN;
> +       if (enabled =3D=3D old_user_read)
> +               return old_user_read;
> +
> +       len =3D scnprintf(buf, sizeof(buf), "%d\n", enabled);
> +       if (lseek(fd, 0, SEEK_SET) < 0) {
> +               pr_debug("%s seek failed\n", __func__);
> +               return old_user_read;
>         }
> +       if (write(fd, buf, len) !=3D len)
> +               pr_debug("%s write failed\n", __func__);
>
> -       len =3D read(rdpmc_fd, buf, sizeof(buf));
> -       if (len !=3D sizeof(buf))
> -               pr_debug("%s read failed\n", __func__);
> +       return old_user_read;
> +}
> +
> +static int set_user_read(struct perf_pmu *pmu, int enabled)
> +{
> +       int events_fd, fd, old_user_read;
>
> -       // Note, on Intel hybrid disabling on 1 PMU will implicitly disab=
le on
> -       // all the core PMUs.
> -       old_user_read =3D (buf[0] =3D=3D '1') ? USER_READ_ENABLED : USER_=
READ_DISABLED;
> +       if (enabled =3D=3D USER_READ_UNKNOWN)
> +               return USER_READ_UNKNOWN;
>
> -       if (enabled !=3D old_user_read) {
> -               buf[0] =3D (enabled =3D=3D USER_READ_ENABLED) ? '1' : '0'=
;
> -               len =3D write(rdpmc_fd, buf, sizeof(buf));
> -               if (len !=3D sizeof(buf))
> -                       pr_debug("%s write failed\n", __func__);
> +       events_fd =3D perf_pmu__event_source_devices_fd();
> +       if (events_fd >=3D 0) {
> +               fd =3D perf_pmu__pathname_fd(events_fd, pmu->name, "rdpmc=
", O_RDWR);
> +               if (fd >=3D 0) {
> +                       /*
> +                        * Note, on Intel hybrid disabling on 1 PMU will
> +                        * implicitly disable on all the core PMUs.
> +                        */
> +                       old_user_read =3D set_user_read_fd(fd, enabled);
> +                       close(fd);
> +                       close(events_fd);
> +                       return old_user_read;
> +               }
> +               close(events_fd);
>         }
> -       close(rdpmc_fd);
> -       close(events_fd);
> +
> +       /* Fallback: perf_user_access interface (arm64, riscv, or similar=
) */
> +       fd =3D open("/proc/sys/kernel/perf_user_access", O_RDWR);
> +       if (fd < 0)
> +               return USER_READ_UNKNOWN;
> +
> +       old_user_read =3D set_user_read_fd(fd, enabled);
> +       close(fd);
>         return old_user_read;
>  }
>
> @@ -240,7 +271,7 @@ static int test_stat_user_read(u64 event, enum user_r=
ead_state enabled)
>         perf_thread_map__set_pid(threads, 0, 0);
>
>         while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> -               enum user_read_state saved_user_read_state =3D set_user_r=
ead(pmu, enabled);
> +               int saved_user_read_state =3D set_user_read(pmu, enabled)=
;
>                 struct perf_event_attr attr =3D {
>                         .type   =3D PERF_TYPE_HARDWARE,
>                         .config =3D perf_pmus__supports_extended_type()
> @@ -253,7 +284,8 @@ static int test_stat_user_read(u64 event, enum user_r=
ead_state enabled)
>                 struct perf_evsel *evsel =3D NULL;
>                 int err;
>                 struct perf_event_mmap_page *pc;
> -               bool mapped =3D false, opened =3D false, rdpmc_supported;
> +               bool mapped =3D false, opened =3D false, rdpmc_expected;
> +               bool rdpmc_event_active;
>                 struct perf_counts_values counts =3D { .val =3D 0 };
>
>
> @@ -301,26 +333,53 @@ static int test_stat_user_read(u64 event, enum user=
_read_state enabled)
>                         goto cleanup;
>                 }
>
> +               /*
> +                * When pc->index =3D=3D 0, userspace access is disabled =
and Perf
> +                * will silently use the read() syscall instead. Test thi=
s to
> +                * make sure we're not doing that.
> +                */
> +               rdpmc_event_active =3D pc->index;
> +
> +               /*
> +                * If we couldn't set the state, test that whatever state=
 we're
> +                * already in is the expected one.
> +                */
>                 if (saved_user_read_state =3D=3D USER_READ_UNKNOWN)
> -                       rdpmc_supported =3D pc->cap_user_rdpmc && pc->ind=
ex;
> +                       rdpmc_expected =3D pc->cap_user_rdpmc && rdpmc_ev=
ent_active;
>                 else
> -                       rdpmc_supported =3D (enabled =3D=3D USER_READ_ENA=
BLED);
> +                       rdpmc_expected =3D (enabled =3D=3D USER_READ_ENAB=
LED);
>
> -               if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc->index=
)) {
> -                       pr_err("User space counter reading for PMU %s [Fa=
iled unexpected supported counter access %d %d]\n",
> -                               pmu->name, pc->cap_user_rdpmc, pc->index)=
;
> +               if (rdpmc_expected && (!pc->cap_user_rdpmc || !rdpmc_even=
t_active)) {
> +                       pr_err("User space counter reading for PMU %s [Fa=
iled. rdpmc event should be both enabled and active %d %d]\n",
> +                               pmu->name, pc->cap_user_rdpmc, rdpmc_even=
t_active);
>                         ret =3D TEST_FAIL;
>                         goto cleanup;
>                 }
>
> -               if (!rdpmc_supported && pc->cap_user_rdpmc) {
> -                       pr_err("User space counter reading for PMU %s [Fa=
iled unexpected unsupported counter access %d]\n",
> -                               pmu->name, pc->cap_user_rdpmc);
> +#ifdef __aarch64__
> +               /*
> +                * On Arm, pc->cap_user_rdpmc is set when the event is op=
ened
> +                * with userspace counter access, regardless of whether r=
dpmc is
> +                * enabled or not via sysfs. The event is always opened w=
ith it
> +                * in this test, so don't check it in the expected disabl=
ed
> +                * case.
> +                */

It seems uapi/linux/perf_event.h should be amended with this meaning.
Currently it says:
```
cap_user_rdpmc          : 1, /* The RDPMC instruction can be used to
read counts */
```
and that lacks the sysfs nuance particular to ARM.

> +               if (!rdpmc_expected && rdpmc_event_active) {
> +                       pr_err("User space counter reading for PMU %s [Fa=
iled. rdpmc event should be inactive %d]\n",
> +                               pmu->name, rdpmc_event_active);
> +                       ret =3D TEST_FAIL;
> +                       goto cleanup;
> +               }
> +#else
> +               if (!rdpmc_expected && pc->cap_user_rdpmc) {
> +                       pr_err("User space counter reading for PMU %s [Fa=
iled. rdpmc event should be disabled and inactive %d %d]\n",
> +                               pmu->name, pc->cap_user_rdpmc, rdpmc_even=
t_active);
>                         ret =3D TEST_FAIL;
>                         goto cleanup;
>                 }
> +#endif

So in the general (non-ARM) case should there be two prints? One for
"disabled" from pc->cap_user_rdpmc and one for "inactive" from
rdpmc_event_active? In that case the cap_user_rdpmc can be skipped on
ARM due to it not adhering to the common behavior.

Thanks,
Ian

>
> -               if (rdpmc_supported && pc->pmc_width < 32) {
> +               if (rdpmc_expected && pc->pmc_width < 32) {
>                         pr_err("User space counter reading for PMU %s [Fa=
iled width not set %d]\n",
>                                 pmu->name, pc->pmc_width);
>                         ret =3D TEST_FAIL;
> @@ -328,7 +387,7 @@ static int test_stat_user_read(u64 event, enum user_r=
ead_state enabled)
>                 }
>
>                 perf_evsel__read(evsel, 0, 0, &counts);
> -               if (rdpmc_supported && counts.val =3D=3D 0) {
> +               if (rdpmc_expected && counts.val =3D=3D 0) {
>                         pr_err("User space counter reading for PMU %s [Fa=
iled read]\n", pmu->name);
>                         ret =3D TEST_FAIL;
>                         goto cleanup;
>
> ---
> base-commit: 6ae6fb96ccd48032b00a38d5f8e0e0a2cce4972b
> change-id: 20260817-rdpmc-detection-logic-d3f7a49cfb46
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
