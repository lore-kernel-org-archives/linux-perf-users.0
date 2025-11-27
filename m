Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286FF330309
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Nov 2025 11:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764244409; cv=none; b=NVMs9KbeUiRUqLIsEhNtG6tKIWYkpMbLeldSUSgBmcoWngOP4XmK/SnFswN9/S2sAuN44pOJ4z2FSWkIdKX4tlPA7TvZ3lTCuSbVB8o4HfUwpa217i7gLZwOIBv468kcmChBEqoZZEMrWdez51xl92q/deyev06tuZ//sg+Cquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764244409; c=relaxed/simple;
	bh=yys6Qk1yW4DNH6UQXPNcsh2DStxIdw4jSPDz5BIYkRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QUAVPP+hOnKpIq3uaFAq/s57dZajOQfVxoTmuTGlF7L6FhGwXTr+148ox2Ekdh8pox2DX4eTGIXJ+F914w1clja/kWyuqo6uhXaU1W303VzgM2EkJ7hMUDwpCRsKP6S0zW+urz0rvkroIudAC+QToSEZBBdaa3nghzi+QlzG4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNVOCtIN; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNVOCtIN"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29852dafa7dso140025ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Nov 2025 03:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764244406; x=1764849206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGqBwUh8o2BdxDtrbLNwfZD6vm+YpWhCAb0ioZQDFRg=;
        b=NNVOCtIN632KrPHRolQezpSJFTQInWf7Xamxug4Uvj+2E7SqJuFfRJmDJJyqs84nYe
         MPKFsvMLw8dyHhx79fPtS8ApU6oYSCtkNOlrs8sHyzYDE0xaUxMDO45yTEsKlGx4RatU
         IkZtPhraE2uvH3SBqEftBeoMznJmoY13XKhg1+/s0q/kvsOTCBDuB9Q2p/xr5rPxNTpN
         aKY4XgqZtm8iVDT6mmSoO5XzOyE4XWG0btcyD4AI3xSllQx0vNUbUvxhFAb6hTCu6KOi
         1jNFUMFD9O33m29qwhom75WSj8FM25K1dMSMoao5CrVM0sADv1nYjYkikFaavPIMBuO2
         ohAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764244406; x=1764849206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pGqBwUh8o2BdxDtrbLNwfZD6vm+YpWhCAb0ioZQDFRg=;
        b=s7/S6QJUuJVdPvu6WXSMEm8BEZm6pV0OxfTpdqkiXXj0P6vH3DL2OAsVgZv5DdySi6
         pSFI1SLUKTI1kMM7lOReBVieYEHB6ghHryU6CKIaD6l4aXo8tD+AhhzcIw0hR+dKhJ9h
         ME8FiPqhySUgyXaIWP9zcPVbdazotOQTLX1/7ABpW+Q5xnFmwCU6WrfX77Ud4f1IjxP7
         gU0PsrWysp3sJt2KHIzDIzsQ0YBL5/PGexQzw3D972KmmCkR0irqXp4mB4RnJ2MTMgSs
         6xkBLh/RpMhANa2NnKvebz48hl0qiVj/evQF0RMD5dzI8CQoF2l/Mb4FeQYRFoWjcgkn
         38tA==
X-Forwarded-Encrypted: i=1; AJvYcCX2DWfWh93SYGJioFMkx8wQL8XKfM+8/OJrWGUbgnbrvt3dqzaVmanVrZhqFuvDjpQ1NXxup3ZzCtwo7gAGAYDY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrp9uTr+YO+8fRBaLZgZnefkBdEbtTUUh8j3nTLGtYdtKjazmV
	Ym61SaBrUN//CUMAj5RuAND91wPaZeST5Z47Sn/BY1rN0+PmjSqrsPeT+HMF7eOG1pRB5HpJKlG
	EL9sy9g8fZ38f1rz9cU0gq0aeYISMub/RxEKaaqUn
X-Gm-Gg: ASbGncvHxurR5WZP5x91NzoN8R8nF8v3nPUa2K3A3A7OqnQtPbOdL+5xkLZIijjaAMk
	UxB1cEYoUUZNNjKMOHu/SqmY24S0Sg3+U7tRLTpRO42yQcgvVfMrk7e6XMhYlFiv3pkMyLXQ8G5
	l1sxeSIhjIhtkuF0fwxU8e3hlp1e/V4bnhdwP9IfaCUb13FJogTBROcX2bTvI4sdJETC+jdBi04
	cermTz1/qsWM3dgXoeS8AcxtFjWm7Utk66Bkqf98F6/HEPBOisVXMPgkMf7XMVDuLXUM/n1
X-Google-Smtp-Source: AGHT+IEFokJ5TTLYGFoUqHkpkFfzzkKl/LLgd7sHJwevMvtVdcvcFdLzBqT/A2DbsEf7IflmfHNMPEKIyUJTavRfNog=
X-Received: by 2002:a17:903:2308:b0:298:45b1:6ef4 with SMTP id
 d9443c01a7336-29bc92a2182mr2014915ad.12.1764244406129; Thu, 27 Nov 2025
 03:53:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com> <20251122081929.7588-18-irogers@google.com>
 <aSaqhlvclSnzJJf1@google.com>
In-Reply-To: <aSaqhlvclSnzJJf1@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Nov 2025 03:53:13 -0800
X-Gm-Features: AWmQ_bl_t3fBBCrnMw6FTrSlfY3N8ocH6HkDeN9R2Tdj-t7mPbxbORh9rR7-GKo
Message-ID: <CAP-5=fVW0Hnf6SfuAC4q-bZtr7h7XkYpQrGLQVj6rXc4Ddh5fQ@mail.gmail.com>
Subject: Re: [PATCH v1 17/17] perf test kvm: Add some basic perf kvm test coverage
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Collin Funk <collin.funk1@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 11:21=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Sat, Nov 22, 2025 at 12:19:29AM -0800, Ian Rogers wrote:
> > Setup qemu with KVM then run kvm stat and some host
> > recording/reporting/build-id tests.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/kvm.sh | 154 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 154 insertions(+)
> >  create mode 100755 tools/perf/tests/shell/kvm.sh
> >
> > diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm=
.sh
> > new file mode 100755
> > index 000000000000..2fafde1a29cc
> > --- /dev/null
> > +++ b/tools/perf/tests/shell/kvm.sh
> > @@ -0,0 +1,154 @@
> > +#!/bin/bash
> > +# perf kvm tests
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +set -e
> > +
> > +err=3D0
> > +perfdata=3D$(mktemp /tmp/__perf_kvm_test.perf.data.XXXXX)
> > +qemu_pid_file=3D$(mktemp /tmp/__perf_kvm_test.qemu.pid.XXXXX)
> > +
> > +cleanup() {
> > +     rm -f "${perfdata}"
> > +     if [ -f "${qemu_pid_file}" ]; then
> > +             if [ -s "${qemu_pid_file}" ]; then
> > +                     qemu_pid=3D$(cat "${qemu_pid_file}")
> > +                     if [ -n "${qemu_pid}" ]; then
> > +                             kill "${qemu_pid}" 2>/dev/null || true
> > +                     fi
> > +             fi
> > +             rm -f "${qemu_pid_file}"
> > +     fi
> > +     trap - EXIT TERM INT
> > +}
> > +
> > +trap_cleanup() {
> > +     echo "Unexpected signal in ${FUNCNAME[1]}"
> > +     cleanup
> > +     exit 1
> > +}
> > +trap trap_cleanup EXIT TERM INT
> > +
> > +skip() {
> > +     echo "Skip: $1"
> > +     cleanup
> > +     exit 2
> > +}
> > +
> > +test_kvm_stat() {
> > +     echo "Testing perf kvm stat"
> > +
> > +     echo "Recording kvm events for pid ${qemu_pid}..."
> > +     if ! perf kvm stat record -p "${qemu_pid}" -o "${perfdata}" sleep=
 1; then
> > +             echo "Failed to record kvm events"
> > +             err=3D1
> > +             return
> > +     fi
> > +
> > +     echo "Reporting kvm events..."
> > +     if ! perf kvm -i "${perfdata}" stat report 2>&1 | grep -q "VM-EXI=
T"; then
> > +             echo "Failed to find VM-EXIT in report"
> > +             perf kvm -i "${perfdata}" stat report 2>&1
> > +             err=3D1
> > +             return
> > +     fi
> > +
> > +     echo "perf kvm stat test [Success]"
> > +}
> > +
> > +test_kvm_record_report() {
> > +     echo "Testing perf kvm record/report"
> > +
> > +     echo "Recording kvm profile for pid ${qemu_pid}..."
> > +     # Use --host to avoid needing guest symbols/mounts for this simpl=
e test
> > +     # We just want to verify the command runs and produces data
> > +     # We run in background and kill it because 'perf kvm record' appe=
nds options
> > +     # after the command, which breaks 'sleep' (e.g. it gets '-e cycle=
s').
> > +     perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
> > +     rec_pid=3D$!
> > +     sleep 1
> > +     kill -INT "${rec_pid}"
> > +     wait "${rec_pid}" || true
> > +
> > +     echo "Reporting kvm profile..."
> > +     # Check for some standard output from report
> > +     if ! perf kvm -i "${perfdata}" report --stdio 2>&1 | grep -q "Eve=
nt count"; then
> > +             echo "Failed to report kvm profile"
> > +             perf kvm -i "${perfdata}" report --stdio 2>&1
> > +             err=3D1
> > +             return
> > +     fi
> > +
> > +     echo "perf kvm record/report test [Success]"
> > +}
> > +
> > +test_kvm_buildid_list() {
> > +     echo "Testing perf kvm buildid-list"
> > +
> > +     # We reuse the perf.data from the previous record test
> > +     if ! perf kvm --host -i "${perfdata}" buildid-list 2>&1 | grep -q=
 "."; then
> > +             echo "Failed to list buildids"
> > +             perf kvm --host -i "${perfdata}" buildid-list 2>&1
> > +             err=3D1
> > +             return
> > +     fi
> > +
> > +     echo "perf kvm buildid-list test [Success]"
> > +}
> > +
> > +setup_qemu() {
> > +     # Find qemu
> > +     if [ "$(uname -m)" =3D "x86_64" ]; then
> > +             qemu=3D"qemu-system-x86_64"
> > +     elif [ "$(uname -m)" =3D "aarch64" ]; then
> > +             qemu=3D"qemu-system-aarch64"
> > +     elif [ "$(uname -m)" =3D "s390x" ]; then
> > +             qemu=3D"qemu-system-s390x"
> > +     elif [ "$(uname -m)" =3D "ppc64le" ]; then
> > +             qemu=3D"qemu-system-ppc64"
> > +     else
> > +             qemu=3D"qemu-system-$(uname -m)"
> > +     fi
> > +
> > +     if ! which -s "$qemu"; then
> > +             skip "$qemu not found"
> > +     fi
> > +
> > +     if [ ! -r /dev/kvm ] || [ ! -w /dev/kvm ]; then
> > +             skip "/dev/kvm not accessible"
> > +     fi
> > +
> > +     if ! perf kvm stat record -a sleep 0.01 >/dev/null 2>&1; then
> > +             skip "No permission to record kvm events"
> > +     fi
> > +
> > +     echo "Starting $qemu..."
> > +     # Start qemu in background, detached, with pidfile
> > +     # We use -display none -daemonize and a monitor to keep it alive/=
controllable if needed
> > +     # We don't need a real kernel, just KVM active.
> > +     if ! $qemu -enable-kvm -display none -daemonize -pidfile "${qemu_=
pid_file}" -monitor none; then
>
> What is running in the guest?

Nothing. As no kernel or storage image were provided the guest should
be waiting at the bios similar to if you booted a PC with no storage
in it. I just wanted something quick and dirty to give the basic perf
kvm command a simple work out for the sake of testing coverage.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +             echo "Failed to start qemu"
> > +             err=3D1
> > +             return
> > +     fi
> > +
> > +     # Wait a bit for qemu to start
> > +     sleep 1
> > +     qemu_pid=3D$(cat "${qemu_pid_file}")
> > +
> > +     if ! kill -0 "${qemu_pid}" 2>/dev/null; then
> > +             echo "Qemu process failed to stay alive"
> > +             err=3D1
> > +             return
> > +     fi
> > +}
> > +
> > +setup_qemu
> > +if [ $err -eq 0 ]; then
> > +     test_kvm_stat
> > +     test_kvm_record_report
> > +     test_kvm_buildid_list
> > +fi
> > +
> > +cleanup
> > +exit $err
> > --
> > 2.52.0.rc2.455.g230fcf2819-goog
> >
