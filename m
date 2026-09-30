Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ACC3CE0B4
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 22:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790806807; cv=pass; b=I2EpZLLKO0AKnOZDyBCkxD17ehxg1Dk7deiG+URHbv/l/9oMD04o7Y9UumBo3E4Y9CeOdGcmIJgeUgBkD0f9mhhVMPTXgQbFEHL5oa0AMjDVu1wJH0rSV2+QFPjbDMa0K9ClXPtoCgTT5KUPSZzMmcDe0x09Z2DFzTFBRpYRPe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790806807; c=relaxed/simple;
	bh=ctlYRUb/qq1JUKtt4v80FaCSsz6jk+XG02lZoJz4UGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z7Gi+gLCcYSeILTxyZvVgNrJsxxhXDwnatoKKkEt5zs2fJdkdRTixTA9PFR+S5dz76pPim1zWTzOInEbE5w+JDmwCL/TyTjS52ZCHKHZGb4cb8CpaurV4VEPu5lfbZlut4Us2AvTG9MCdf6RjH2Ny7PVwEKTuePuXQxaVgdA2U8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m4CHoY0a; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m4CHoY0a"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5337fa12431so56921cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 15:20:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790806803; cv=none;
        d=google.com; s=arc-20260327;
        b=DlopU2WiSvghswJ/CyDtIw6iXWKpRd0DtVhSSTdyTWSirVHGj9V6SomgDKK6pD1e8n
         z2ACtPTAZbxzu9svJX8Ghp5Kpuz4RY3ZM7N4ZElvrd8jXYuvVPi8QNmGQKXUll59A0Zj
         gfxdQZzIHKBbEFPBA8Ap7YTwkCLzHXO30DcIYpCYxi/p3nPjszOa0fDKbhArjqpXQE0H
         X2KyrU/IPoI5aJxiJdkygHzgHUPMeiWSJf3dr0tuaSkeslRAIjhhSLcDHvoyN7dnUslL
         af4SGDq225pkavXizNhR6ywhdZzzuvpJghfKqeWU6/5AK9cnHIvWLLs9oYQubmSydCdC
         wZ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d2qN2zrp0yIz6tOqupMlcxv9Q/3p0BhatXCTGzZ3ur8=;
        fh=g69DOkbj6v8NLynr77FqvisRXbb13/xyjlw1tQjzdK0=;
        b=iSYSPCwKIEFgiz/GZzy3KpZGHrhgHvc22auFbDiTea0d21rp2R/+LHyqAwPwiQ2Sgr
         3EQsVXr/PBu0Z07FA1oFjsHSqQZnKxMaLSfG71iK5vDywsjbxMzGiBtqmoXgNrDlABJn
         SJDMZku3azUEIB7v/Bl7n4nrSx+UkcbeJlgAsO1GbxGq62UrRcIlxZBwWvpZxHe5K6Kv
         Lj1NXN3/5dv1vfRDa7OKZl8LL0o7dc7pXZi1pKCaaeA2mC/hbtSNGya7j2lIhE36BDho
         MrvNRTlvBwqwla388CDRXW/oHSnuIvvUjVXOH6s81JHUbleJwKzS7V7JEZ46yiDFO+nE
         Mx2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790806803; x=1791411603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d2qN2zrp0yIz6tOqupMlcxv9Q/3p0BhatXCTGzZ3ur8=;
        b=m4CHoY0a6g/4w6GsrcrNBrG7Ehf+ClZIwqN/faBPlv1ElzfCppQwf3UjmiKuzXgtpI
         yQUbWQkehcX30ClUWFvELBq6k7WBYAHQwzExbhlQeSiWB6AccLJMC3tzCA3vovGPE9zU
         auwiHiVFwqecbNE8hFD/PwuC7Htc24nLnw/dFS84WIf3qzhbcfxGxQUe9tNjiYMPWyb5
         AcTNeq0WX5c7Yko4sn5PzYRyh/oNYSkF/hYU+s5SKjjNH+bSGePicIt3QSjYWh2SDc39
         kzHgGDfa00vQ4+n9tHggspTL2Q0MCDajzajx1G9JpM73C83WAqjzOr+1gQw212AHvjtM
         qVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790806803; x=1791411603;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d2qN2zrp0yIz6tOqupMlcxv9Q/3p0BhatXCTGzZ3ur8=;
        b=odFqpPMwyXcMGmvnMqcRxBqUzA077hSxD7+09B/8X2SAsZc2wqRv6hHbslh2z8WoV3
         PH40YXccgFzei+WwnomxLt7XS5vw6hyB6m/8OaRmoqAs9VsghZVVK64dYFAp39Fx2VG5
         rojaAXEff1l1Y4B7+OspGR1x+TVs31Y7wZMaBb/36Sl5yHHQkyiNK5sNl3OwIQSS3oHS
         YDX89s9XIPgOHmo0U7hLT7v2f3nz5MgRuxuBmlNhZPCK/D2X6K/l10tewE0j7bgMRWaS
         dsYRepM6CraRntN55WeHLmFkKlL/+cINkRBRXH0s0mgMAe9ayTSPBdrn9gpecAMUzNKV
         Pw9A==
X-Forwarded-Encrypted: i=1; AKwUvBxqbBA8vyuWECalEoV8dxXdks0mJuozL6zx1oNRNemPlnNQbl02sVrL+ERcQFMyG/8ijiJOXj4xphyLWDfX+blG@vger.kernel.org
X-Gm-Message-State: AFuF++l8wyxuBOCerNYy66lHP9B08eLLkAKmoEfIIE6LJV9BjMpNyh83
	FJD3iE8br5twpvLMiR3WZlP3tNASZWyDvT5rv+PqCzUv6kjjxdU6G8K8egFGWIKmgguhTc1babF
	BQl2HBp/eic4UzRHepz+oqxs0jyclw1Y3X5OmzMR/
X-Gm-Gg: AYBFou35vCHFVc98+Wn6nth9AONXR8AgYCZQpDBHkP79KyCao4SPMUlSB9H0VJBiprb
	y/TxDDvHtFswylJmAWQk+6Pn1ErHI+uhhmtUy7hMN/aoS3j7HumCvaixsVqy799E0KZeBVnX3qh
	Rd4Y3U1eWtCvs37WluDPs3U6QpSI1epq+90QQHcKOqFekWpLy72TWiFqdIOg+62sS9q7r1qlV7G
	Y7pOHpRlWDthPLyTobvaHwsnagMpaxfIhLI0nnOi1efIwEzqHY9yd4LdzLETVV3f7By1cqazP2r
	60RxfWe96hcMu0eyWdVnzO1K/yS+lwg1AvfEpYdQhnRDtAckvdi/x3AWyfVYOsYYjuGnNCjdvD/
	ncmgvQnVq
X-Received: by 2002:a05:622a:258c:b0:531:a85:69c1 with SMTP id
 d75a77b69052e-533867833f9mr2914291cf.5.1790806801994; Wed, 30 Sep 2026
 15:20:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817-rdpmc-detection-logic-v4-1-c22074578f6a@linaro.org>
 <CAP-5=fWw6-NsAOjSUSNFgnA0vNg1pbE=Yf=QwF54y97WTdjXyQ@mail.gmail.com>
 <066f843e-0b87-4860-bb8c-c6714a5f57c8@linaro.org> <c7366728-5242-4420-b99c-aef08ce04d4d@linaro.org>
In-Reply-To: <c7366728-5242-4420-b99c-aef08ce04d4d@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Sep 2026 15:19:50 -0700
X-Gm-Features: AclHuK_k3jbkUm8BtQS73VPj1hlAZfmgbmhXkfC5MHTCRUZv5GlEmlE1fes11yQ
Message-ID: <CAP-5=fUBt17k6x8_JJiFn-EDZ5HF0T8L_2Au=rRARTCV-gxULw@mail.gmail.com>
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

On Wed, Sep 30, 2026 at 6:29=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 18/08/2026 11:04, James Clark wrote:
> >
> > On 17/08/2026 20:13, Ian Rogers wrote:
> >> On Mon, Aug 17, 2026 at 8:54=E2=80=AFAM James Clark <james.clark@linar=
o.org>
> >> wrote:
> >>>
> >>> From: Qiao Zhao <qzhao@redhat.com>
> >>>
> >>> RISC-V and Arm control userspace counter access through
> >>> /proc/sys/kernel/perf_user_access. Add that as a fallback to
> >>> set_user_read() so the test can test both the enabled and disabled
> >>> states on those platforms. RISC-V also uses a '2' value rather than j=
ust
> >>> 0 or 1 so add support for restoring arbitrary values.
> >>>
> >>> On Arm, cap_user_rdpmc will always be set when requested, even if the
> >>> global setting is disabled. This is so that the feature can be enable=
d
> >>> or revoked while events are live. Skip checking it on Arm for the
> >>> "expected disabled" case, otherwise the test will fail.
> >>>
> >>> Add comments, more meaningful variable names and improve the error
> >>> messages so that it's clearer what this part of the test is doing.
> >>>
> >>> Signed-off-by: Qiao Zhao <qzhao@redhat.com>
> >>> [Test pc->index, fix bugs in set_user_read(), and simplify commit msg=
]
> >>> Assisted-by: Codex:GPT-5.6
> >>> Signed-off-by: James Clark <james.clark@linaro.org>
> >>> ---
> >>> I'm sending this to fix the comments that I left on the "V3 resend"
> >>> because I don't think Qiao sent a V4 and it's been quite a while.
> >>>
> >>> There were also some unreported bugs that I found during testing.
> >>>
> >>> Changes in V4:
> >>>   - Don't remove pc->index check. Without it Perf can silently fall b=
ack
> >>>     to the read() syscall and the test is useless.
> >>>   - Test the 'expected disabled' case for Arm in an ifdef to workarou=
nd
> >>>     platform differences.
> >>>   - lseek() before writing to perf_user_access otherwise it's ignored=
.
> >>>   - Support restoring arbitrary values to perf_user_access because
> >>> RISC-V
> >>>     uses '2' for legacy mode.
> >>
> >> What does that mean? Should there be corresponding "legacy" support in
> >> libperf?
> >>
> >
> > I don't think so, it looks like more of a security thing and 'legacy'
> > isn't really supposed to be used. It was only added in case someone
> > wants to go back to the original insecure behavior:
> >
> >    "We used to unconditionnally expose the cycle and instret csrs to
> >     userspace, which gives rise to security concerns. So now we only
> >     allow access to hw counters from userspace through the perf
> >     framework which will handle context switches, per-task events...etc=
.
> >     A sysctl allows to revert the behaviour to the legacy mode so that
> >     userspace applications which are not ready for this change do not
> >     break."
> >
> >    drivers/perf/riscv_pmu_sbi.c:
> >
> >    #define SYSCTL_NO_USER_ACCESS    0
> >    #define SYSCTL_USER_ACCESS    1
> >    #define SYSCTL_LEGACY        2
> >
> > I added this so that the test doesn't overwrite an existing legacy valu=
e
> > and then not restore it which could break their system after running th=
e
> > Perf tests.

So if a driver does something outside the specification, a failing
test seems like a good signal. By which I mean, supporting 2 here
seems to make the test less useful.

> >>>   - Rename rdpmc_supported to rdpmc_expected as this is what the test
> >>>     expects, not what the system does.
> >>
> >> Can you explain the distinction here? The test expects that if
> >> userspace reading is enabled, it should be supported. Imo this makes a
> >> line like:
> >> ```
> >> if (rdpmc_supported && counts.val =3D=3D 0) {
> >> ```
> >> easy to read. The same line with rdpmc_expected, well I need to then
> >> go and figure out what expected should mean and it seems to just mean
> >
> > rdpmc_supported was already defined somewhere else, I only renamed it s=
o
> > I'm not sure having to go and figure anything out is a strong argument.
> >
> >> supported, so the code was more readable before.
> >>
> >
> > I don't think it does mean supported, the default case is this one:
> >
> >    rdpmc_expected =3D (enabled =3D=3D USER_READ_ENABLED);
> >
> > That's not whether the system supports it or has enabled it or not, it'=
s
> > what the test attempted to write into sysfs and what is expected for
> > that invocation of the function. The system might not actually support
> > it or have enabled it, and in that case the test should fail because
> > expected !=3D active. If writing into the sysfs file was silently not
> > accepted then you can't assume enabled =3D=3D supported (unless you rea=
d
> > back the file which the test doesn't do, it just blindly writes and the=
n
> > assumes it worked, i.e. "expects").

No, if the enablement fails, the test should have failed earlier or
the enabled value be "unknown". I think rdpmc_expected is a much worse
variable name. If we can't know if rpdmc is supported then the API
seems wrong, as how could a user know this and reasonably use an rdpmc
instruction?

> > I was trying to separate the concepts of what the system has done vs
> > what the test expects. I thought "expected" is quite a common term in
> > testing for test derived variables, but it's just a variable name so I'=
m
> > not too set on it, but I do think it's an improvement.

I agree expected is a common testing term and is weaker than asserted.
I want this test to categorically say when rdpmc is supported, not
just expected to be supported. The underlying implementation matches
the perf_event.h description and I wanted the test to serve as
documentation.

> >>>   - Label pc->index as rdpmc_event_active for clarity.
> >>>   - Add comments and simplify the commit message.
> >>> ---
> >>>   tools/perf/tests/mmap-basic.c | 137 +++++++++++++++++++++++++++++
> >>> +------------
> >>>   1 file changed, 98 insertions(+), 39 deletions(-)
> >>>
> >>> diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-
> >>> basic.c
> >>> index 5cec7644952c..4433a5df3d77 100644
> >>> --- a/tools/perf/tests/mmap-basic.c
> >>> +++ b/tools/perf/tests/mmap-basic.c
> >>> @@ -1,6 +1,7 @@
> >>>   // SPDX-License-Identifier: GPL-2.0
> >>>   #include <errno.h>
> >>>   #include <inttypes.h>
> >>> +#include <limits.h>
> >>>   #include <stdlib.h>
> >>>
> >>>   #include <fcntl.h>
> >>> @@ -182,47 +183,77 @@ static int test__basic_mmap(struct test_suite
> >>> *test __maybe_unused, int subtest
> >>>   }
> >>>
> >>>   enum user_read_state {
> >>> -       USER_READ_ENABLED,
> >>> -       USER_READ_DISABLED,
> >>> -       USER_READ_UNKNOWN,
> >>> +       USER_READ_UNKNOWN =3D -1,
> >>> +       USER_READ_DISABLED =3D 0,
> >>> +       USER_READ_ENABLED =3D 1,
> >>>   };
> >>>
> >>> -static enum user_read_state set_user_read(struct perf_pmu *pmu, enum
> >>> user_read_state enabled)
> >>> +static int set_user_read_fd(int fd, int enabled)
> >>
> >> Why change this to an int rather than adding "legacy" to the
> >> user_read_state enum? An int gives far more potential values than the
> >> enum and so appears inherently less intention-revealing.
> >>
> >
> > I did consider it but I didn't think it was very future proof. This
> > would then break a system when someone adds a 3. If we weren't restorin=
g
> > whatever value is read then I would agree just using the enum would mak=
e
> > sense, but I think it should handle any integer. Wouldn't this just
> > trade functionality for style?

So using the integer removes the documentation aspect of the test that
there are only 2 known values.

> >>>   {
> >>> -       char buf[2] =3D {0, '\n'};
> >>> +       char buf[32], *endptr;
> >>> +       long value;
> >>>          ssize_t len;
> >>> -       int events_fd, rdpmc_fd;
> >>> -       enum user_read_state old_user_read =3D USER_READ_UNKNOWN;
> >>> +       int old_user_read;
> >>>
> >>> -       if (enabled =3D=3D USER_READ_UNKNOWN)
> >>> +       len =3D read(fd, buf, sizeof(buf) - 1);
> >>> +       if (len <=3D 0) {
> >>> +               pr_debug("%s read failed\n", __func__);
> >>>                  return USER_READ_UNKNOWN;
> >>> +       }
> >>> +       buf[len] =3D '\0';
> >>>
> >>> -       events_fd =3D perf_pmu__event_source_devices_fd();
> >>> -       if (events_fd < 0)
> >>> +       errno =3D 0;
> >>> +       value =3D strtol(buf, &endptr, 10);
> >>> +       if (errno || endptr =3D=3D buf || value < 0 || value > INT_MA=
X) {
> >>
> >> Given we're range checking the read value, can the upper bound be "> 2=
" ?
> >>
> >
> > Is there a particular reason to? Similarly to above, I only think this
> > will cause issues when new values are added. At the moment the test is
> > immune to it.

Yes, so the test can document the kernel behavior (or at least what it
should be).

> >>> +               pr_debug("%s invalid value: %s\n", __func__, buf);
> >>>                  return USER_READ_UNKNOWN;
> >>> +       }
> >>> +       old_user_read =3D value;
> >>>
> >>> -       rdpmc_fd =3D perf_pmu__pathname_fd(events_fd, pmu->name,
> >>> "rdpmc", O_RDWR);
> >>> -       if (rdpmc_fd < 0) {
> >>> -               close(events_fd);
> >>> -               return USER_READ_UNKNOWN;
> >>> +       if (enabled =3D=3D old_user_read)
> >>> +               return old_user_read;
> >>> +
> >>> +       len =3D scnprintf(buf, sizeof(buf), "%d\n", enabled);
> >>> +       if (lseek(fd, 0, SEEK_SET) < 0) {
> >>> +               pr_debug("%s seek failed\n", __func__);
> >>> +               return old_user_read;
> >>>          }
> >>> +       if (write(fd, buf, len) !=3D len)
> >>> +               pr_debug("%s write failed\n", __func__);
> >>>
> >>> -       len =3D read(rdpmc_fd, buf, sizeof(buf));
> >>> -       if (len !=3D sizeof(buf))
> >>> -               pr_debug("%s read failed\n", __func__);
> >>> +       return old_user_read;
> >>> +}
> >>> +
> >>> +static int set_user_read(struct perf_pmu *pmu, int enabled)
> >>> +{
> >>> +       int events_fd, fd, old_user_read;
> >>>
> >>> -       // Note, on Intel hybrid disabling on 1 PMU will implicitly
> >>> disable on
> >>> -       // all the core PMUs.
> >>> -       old_user_read =3D (buf[0] =3D=3D '1') ? USER_READ_ENABLED :
> >>> USER_READ_DISABLED;
> >>> +       if (enabled =3D=3D USER_READ_UNKNOWN)
> >>> +               return USER_READ_UNKNOWN;
> >>>
> >>> -       if (enabled !=3D old_user_read) {
> >>> -               buf[0] =3D (enabled =3D=3D USER_READ_ENABLED) ? '1' :=
 '0';
> >>> -               len =3D write(rdpmc_fd, buf, sizeof(buf));
> >>> -               if (len !=3D sizeof(buf))
> >>> -                       pr_debug("%s write failed\n", __func__);
> >>> +       events_fd =3D perf_pmu__event_source_devices_fd();
> >>> +       if (events_fd >=3D 0) {
> >>> +               fd =3D perf_pmu__pathname_fd(events_fd, pmu->name,
> >>> "rdpmc", O_RDWR);
> >>> +               if (fd >=3D 0) {
> >>> +                       /*
> >>> +                        * Note, on Intel hybrid disabling on 1 PMU w=
ill
> >>> +                        * implicitly disable on all the core PMUs.
> >>> +                        */
> >>> +                       old_user_read =3D set_user_read_fd(fd, enable=
d);
> >>> +                       close(fd);
> >>> +                       close(events_fd);
> >>> +                       return old_user_read;
> >>> +               }
> >>> +               close(events_fd);
> >>>          }
> >>> -       close(rdpmc_fd);
> >>> -       close(events_fd);
> >>> +
> >>> +       /* Fallback: perf_user_access interface (arm64, riscv, or
> >>> similar) */
> >>> +       fd =3D open("/proc/sys/kernel/perf_user_access", O_RDWR);
> >>> +       if (fd < 0)
> >>> +               return USER_READ_UNKNOWN;
> >>> +
> >>> +       old_user_read =3D set_user_read_fd(fd, enabled);
> >>> +       close(fd);
> >>>          return old_user_read;
> >>>   }
> >>>
> >>> @@ -240,7 +271,7 @@ static int test_stat_user_read(u64 event, enum
> >>> user_read_state enabled)
> >>>          perf_thread_map__set_pid(threads, 0, 0);
> >>>
> >>>          while ((pmu =3D perf_pmus__scan_core(pmu)) !=3D NULL) {
> >>> -               enum user_read_state saved_user_read_state =3D
> >>> set_user_read(pmu, enabled);
> >>> +               int saved_user_read_state =3D set_user_read(pmu, enab=
led);
> >>>                  struct perf_event_attr attr =3D {
> >>>                          .type   =3D PERF_TYPE_HARDWARE,
> >>>                          .config =3D perf_pmus__supports_extended_typ=
e()
> >>> @@ -253,7 +284,8 @@ static int test_stat_user_read(u64 event, enum
> >>> user_read_state enabled)
> >>>                  struct perf_evsel *evsel =3D NULL;
> >>>                  int err;
> >>>                  struct perf_event_mmap_page *pc;
> >>> -               bool mapped =3D false, opened =3D false, rdpmc_suppor=
ted;
> >>> +               bool mapped =3D false, opened =3D false, rdpmc_expect=
ed;
> >>> +               bool rdpmc_event_active;
> >>>                  struct perf_counts_values counts =3D { .val =3D 0 };
> >>>
> >>>
> >>> @@ -301,26 +333,53 @@ static int test_stat_user_read(u64 event, enum
> >>> user_read_state enabled)
> >>>                          goto cleanup;
> >>>                  }
> >>>
> >>> +               /*
> >>> +                * When pc->index =3D=3D 0, userspace access is disab=
led
> >>> and Perf
> >>> +                * will silently use the read() syscall instead. Test
> >>> this to
> >>> +                * make sure we're not doing that.
> >>> +                */
> >>> +               rdpmc_event_active =3D pc->index;
> >>> +
> >>> +               /*
> >>> +                * If we couldn't set the state, test that whatever
> >>> state we're
> >>> +                * already in is the expected one.
> >>> +                */
> >>>                  if (saved_user_read_state =3D=3D USER_READ_UNKNOWN)
> >>> -                       rdpmc_supported =3D pc->cap_user_rdpmc && pc-
> >>> >index;
> >>> +                       rdpmc_expected =3D pc->cap_user_rdpmc &&
> >>> rdpmc_event_active;
> >>>                  else
> >>> -                       rdpmc_supported =3D (enabled =3D=3D
> >>> USER_READ_ENABLED);
> >>> +                       rdpmc_expected =3D (enabled =3D=3D USER_READ_=
ENABLED);
> >>>
> >>> -               if (rdpmc_supported && (!pc->cap_user_rdpmc || !pc-
> >>> >index)) {
> >>> -                       pr_err("User space counter reading for PMU %s
> >>> [Failed unexpected supported counter access %d %d]\n",
> >>> -                               pmu->name, pc->cap_user_rdpmc, pc-
> >>> >index);
> >>> +               if (rdpmc_expected && (!pc->cap_user_rdpmc || !
> >>> rdpmc_event_active)) {
> >>> +                       pr_err("User space counter reading for PMU %s
> >>> [Failed. rdpmc event should be both enabled and active %d %d]\n",
> >>> +                               pmu->name, pc->cap_user_rdpmc,
> >>> rdpmc_event_active);
> >>>                          ret =3D TEST_FAIL;
> >>>                          goto cleanup;
> >>>                  }
> >>>
> >>> -               if (!rdpmc_supported && pc->cap_user_rdpmc) {
> >>> -                       pr_err("User space counter reading for PMU %s
> >>> [Failed unexpected unsupported counter access %d]\n",
> >>> -                               pmu->name, pc->cap_user_rdpmc);
> >>> +#ifdef __aarch64__
> >>> +               /*
> >>> +                * On Arm, pc->cap_user_rdpmc is set when the event
> >>> is opened
> >>> +                * with userspace counter access, regardless of
> >>> whether rdpmc is
> >>> +                * enabled or not via sysfs. The event is always
> >>> opened with it
> >>> +                * in this test, so don't check it in the expected
> >>> disabled
> >>> +                * case.
> >>> +                */
> >>
> >> It seems uapi/linux/perf_event.h should be amended with this meaning.
> >> Currently it says:
> >> ```
> >> cap_user_rdpmc          : 1, /* The RDPMC instruction can be used to
> >> read counts */
> >> ```
> >> and that lacks the sysfs nuance particular to ARM.
> >>
> >
> > Do we need to mention sysfs here? The other platforms have the PMU rdpm=
c
> > file which isn't mentioned.
> >
> > I can change it to this which would apply to all platforms:
> >
> > /* The RDPMC instruction can be used to read counts if pc->index is set=
 */
> >
> > The examples in that file already check pc->index, so I suppose there
> > isn't really anything Arm specific if it's phrased that way. If
> > cap_user_rdpmc was already enough to gate reading, then the examples
> > wouldn't have included the pc->index check as well.

So if there's nothing ARM specific then let's keep this test generic
and not introduce an "#ifdef __aarch64__".

> >>> +               if (!rdpmc_expected && rdpmc_event_active) {
> >>> +                       pr_err("User space counter reading for PMU %s
> >>> [Failed. rdpmc event should be inactive %d]\n",
> >>> +                               pmu->name, rdpmc_event_active);
> >>> +                       ret =3D TEST_FAIL;
> >>> +                       goto cleanup;
> >>> +               }
> >>> +#else
> >>> +               if (!rdpmc_expected && pc->cap_user_rdpmc) {
> >>> +                       pr_err("User space counter reading for PMU %s
> >>> [Failed. rdpmc event should be disabled and inactive %d %d]\n",
> >>> +                               pmu->name, pc->cap_user_rdpmc,
> >>> rdpmc_event_active);
> >>>                          ret =3D TEST_FAIL;
> >>>                          goto cleanup;
> >>>                  }
> >>> +#endif
> >>
> >> So in the general (non-ARM) case should there be two prints? One for
> >> "disabled" from pc->cap_user_rdpmc and one for "inactive" from
> >> rdpmc_event_active?
> >
> > I assumed that myself and tried adding it so it was symmetrical to the
> > "expected enabled" case. But there is another platform difference,
> > PowerPC seems to set pc->index (rdpmc_event_active) even when the cap i=
s
> > disabled. So you have to check both the cap and index are set for the
> > enabled case but only check the cap for the disabled case (everywhere
> > execpt Arm). I assume that's why index is missing or was removed from
> > this test in the first place.
> >
> > Honestly it is quite a bit of a mess, but I think getting away with onl=
y
> > one platform conditional and not weakening any of the existing tests is
> > quite a good outcome.

So I'm in favor of cleaning this up and having the test serve as good
documentation. The patch as-is makes this situation worse, in my
opinion.

> >> In that case the cap_user_rdpmc can be skipped on
> >> ARM due to it not adhering to the common behavior.
> >>
> >> Thanks,
> >> Ian
> >>
> >>>
> >>> -               if (rdpmc_supported && pc->pmc_width < 32) {
> >>> +               if (rdpmc_expected && pc->pmc_width < 32) {
> >>>                          pr_err("User space counter reading for PMU
> >>> %s [Failed width not set %d]\n",
> >>>                                  pmu->name, pc->pmc_width);
> >>>                          ret =3D TEST_FAIL;
> >>> @@ -328,7 +387,7 @@ static int test_stat_user_read(u64 event, enum
> >>> user_read_state enabled)
> >>>                  }
> >>>
> >>>                  perf_evsel__read(evsel, 0, 0, &counts);
> >>> -               if (rdpmc_supported && counts.val =3D=3D 0) {
> >>> +               if (rdpmc_expected && counts.val =3D=3D 0) {
> >>>                          pr_err("User space counter reading for PMU
> >>> %s [Failed read]\n", pmu->name);
> >>>                          ret =3D TEST_FAIL;
> >>>                          goto cleanup;
> >>>
> >>> ---
> >>> base-commit: 6ae6fb96ccd48032b00a38d5f8e0e0a2cce4972b
> >>> change-id: 20260817-rdpmc-detection-logic-d3f7a49cfb46
> >>>
> >>> Best regards,
> >>> --
> >>> James Clark <james.clark@linaro.org>
> >>>
> >
>
> Hi Ian,
>
> Any thoughts on these comments? I think it would be good to get this
> merged, and it still applies cleanly. I just ran into the issue that
> this fixes again and got reminded of it.

Sorry for the delay, your comments seemed to imply another version was
going to come.

Thanks,
Ian

> Thanks
> James
>
