Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1BD3002AF
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Nov 2025 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764320797; cv=none; b=lswynMW80Qvs6qH+OxvR9wSGOCkp/eZsefumjUtAYVohN35t0dFrR+zVFQNbRV5SOCFpd2Rm1qKxixzT2/KUnK70BJdz4jOMqc90df3xUO/kv46Jn4zGhFUb07xGDYEiP5EYhCTCNe29bSRpZuUPHy1tU/bUN/VOVyBQMTkDDxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764320797; c=relaxed/simple;
	bh=mepeeWfB5Fp49aF4gCqTILrqltQwvgkdlxA3+dTqC0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubikOI3u0rHCx2ogU+dHEa39YA4pXhCr+QnOKFa7gsbTHKiQP1fY+LwKETEVjF6Jhz7lZG7fm9Xq7ZSX4rjWXAZUFUsiPgVLFXXKp1Wl61ClSoa8GgEQ60im5DIM3VfjFn7HFJf5gZza22PI/fsWZ6ruhL+GR6p20S635bgbvxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=frjpveN9; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="frjpveN9"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297e13bf404so312885ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 28 Nov 2025 01:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764320795; x=1764925595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oqs8LnX2OY4gSUrKyr7QJ8PLW9/ZifNP7B4CESBV4EM=;
        b=frjpveN9DaaaT4AZkMTi7LIvPBgwauimA052wvm+q2/tzCQG5h0YbY7tSJgPLID4oY
         1T4LNpebzEdAOH50gph7dKz67/jS+ulnWKfwNiglPQV2zefrCCzZ+r6AMkfi9OIZ8g4f
         g+0vAzTEPd46l+D86RFetQ5mfMdQZseGOuYDX1li75yqnw4qlkaqds2jFQOQ31CiwVJR
         D+MdvgPSIhRC5xa1UceQnH1z2Z3QIXeAcd8NH9lffgHmP+hHlQhuPdNzK6KpWuIujY4K
         6FClFmyRERHqGxwdhq6nkQNckqLMHo+q4MKbqJjKat9jjwd6pVxEMolCO8qtLM8f5WKj
         HChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764320795; x=1764925595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Oqs8LnX2OY4gSUrKyr7QJ8PLW9/ZifNP7B4CESBV4EM=;
        b=WlG/6p9jBkHZAmDtD+faMcjvbu+rD4q3HwuNtcnJLBx8LW2Aascd9jAaOlNtFH7yuJ
         6o8FwWr7hur1e5FRZt9m/TE+nw4ozmXkAy9ElTjk3fgm+tmedElL5pIxeXUnjw/oFOjR
         tfGFVF5qxtJVagKPYTdR0uc7+dPPv5OuW0dSMrndOWfQotW8L2PntRZAmIA164+dIr1A
         Hd/8RtBlRJ4fek6mEZpAYSp/vYCNvtEiWtTKBb2p+7i7jHYaNhqhoDAiXNwHUpgLFgii
         IxTidzdXHnyQFQlSD0VQFEzwK+flJPzcMOv1RL4peGkVlyWvM73YAlFw9tuEDFJU/CxY
         fMxw==
X-Forwarded-Encrypted: i=1; AJvYcCUvcXEU6lEfpjgnaXbReOVgNJ79+FIZ7Zmc5s/zr3E9WFxEyFK/tpmNwUon6W8elhhOyWYv1mfvLW6UJ+5coQr4@vger.kernel.org
X-Gm-Message-State: AOJu0YyipFdHb95sjyOFZSsO8waWa4Csc/oqfyE0sx0u59SL6BIldYtm
	1wa8Q4Vn2iFY7ETa+WECqrv6Av0Qu6R/T6lrUmV1sYUbf8Nfph/M2G5fO9/OYSZDx9dJVGUaUYF
	6seTUs6cXx6iV9760UM9ILijRpfofAIdZ5pjhZiM+
X-Gm-Gg: ASbGncvsgZAE24QppeDYkUC7A9McWYrOYOVx/jIRCbG08mWE7ELh+s6S5coaJ4mngbz
	ycz/AloMDZUXUEIAXGcL3LT4EPAfP9pkaILl8terz4fan50GH01w4VjqbXmALUPUNqxIMQko6Ak
	WX8eMCk/s7dvwNQemjRahNjKkqTOlLHNF/eEfdbROaRMYdXGbTDOP6P/bm1IG3EFk788mqEBJKM
	M0gOutpF+g7vHc29ZCyTvQufoQ7NsfPbgBtiu9qckTBNdPDUslOp7X2ZcrtK0aI/L8QivTe
X-Google-Smtp-Source: AGHT+IFQWKIw8BDGfajD8e1QAqYCVMKlEqZ0VKAV9UM4R32U5AkvQZQWlwM7XNbjfhIY/0mzu/qX6N2NOTIaLb55S+o=
X-Received: by 2002:a17:902:e5c3:b0:291:6488:5af5 with SMTP id
 d9443c01a7336-29bca2adfaemr3343555ad.1.1764320794746; Fri, 28 Nov 2025
 01:06:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251122081929.7588-1-irogers@google.com> <20251122081929.7588-18-irogers@google.com>
 <aSaqhlvclSnzJJf1@google.com> <CAP-5=fVW0Hnf6SfuAC4q-bZtr7h7XkYpQrGLQVj6rXc4Ddh5fQ@mail.gmail.com>
 <aSi6uGZdIqxLuyhz@google.com>
In-Reply-To: <aSi6uGZdIqxLuyhz@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 28 Nov 2025 01:06:22 -0800
X-Gm-Features: AWmQ_ble0V8r7R8xkzuvUAImQoPR6sh8YtP-qPp6rQt50xoUclY04GtY__vPHis
Message-ID: <CAP-5=fWrbHu75NZcYn7NETDb057uZA6NGpOFADMWNgHRyxfCsA@mail.gmail.com>
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

On Thu, Nov 27, 2025 at 12:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Nov 27, 2025 at 03:53:13AM -0800, Ian Rogers wrote:
> > On Tue, Nov 25, 2025 at 11:21=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Sat, Nov 22, 2025 at 12:19:29AM -0800, Ian Rogers wrote:
> > > > Setup qemu with KVM then run kvm stat and some host
> > > > recording/reporting/build-id tests.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/tests/shell/kvm.sh | 154 ++++++++++++++++++++++++++++++=
++++
> > > >  1 file changed, 154 insertions(+)
> > > >  create mode 100755 tools/perf/tests/shell/kvm.sh
> > > >
> > > > diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell=
/kvm.sh
> > > > new file mode 100755
> > > > index 000000000000..2fafde1a29cc
> > > > --- /dev/null
> > > > +++ b/tools/perf/tests/shell/kvm.sh
> > > > @@ -0,0 +1,154 @@
> > > > +#!/bin/bash
> > > > +# perf kvm tests
> > > > +# SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +set -e
> > > > +
> > > > +err=3D0
> > > > +perfdata=3D$(mktemp /tmp/__perf_kvm_test.perf.data.XXXXX)
> > > > +qemu_pid_file=3D$(mktemp /tmp/__perf_kvm_test.qemu.pid.XXXXX)
> > > > +
> > > > +cleanup() {
> > > > +     rm -f "${perfdata}"
> > > > +     if [ -f "${qemu_pid_file}" ]; then
> > > > +             if [ -s "${qemu_pid_file}" ]; then
> > > > +                     qemu_pid=3D$(cat "${qemu_pid_file}")
> > > > +                     if [ -n "${qemu_pid}" ]; then
> > > > +                             kill "${qemu_pid}" 2>/dev/null || tru=
e
> > > > +                     fi
> > > > +             fi
> > > > +             rm -f "${qemu_pid_file}"
> > > > +     fi
> > > > +     trap - EXIT TERM INT
> > > > +}
> > > > +
> > > > +trap_cleanup() {
> > > > +     echo "Unexpected signal in ${FUNCNAME[1]}"
> > > > +     cleanup
> > > > +     exit 1
> > > > +}
> > > > +trap trap_cleanup EXIT TERM INT
> > > > +
> > > > +skip() {
> > > > +     echo "Skip: $1"
> > > > +     cleanup
> > > > +     exit 2
> > > > +}
> > > > +
> > > > +test_kvm_stat() {
> > > > +     echo "Testing perf kvm stat"
> > > > +
> > > > +     echo "Recording kvm events for pid ${qemu_pid}..."
> > > > +     if ! perf kvm stat record -p "${qemu_pid}" -o "${perfdata}" s=
leep 1; then
> > > > +             echo "Failed to record kvm events"
> > > > +             err=3D1
> > > > +             return
> > > > +     fi
> > > > +
> > > > +     echo "Reporting kvm events..."
> > > > +     if ! perf kvm -i "${perfdata}" stat report 2>&1 | grep -q "VM=
-EXIT"; then
> > > > +             echo "Failed to find VM-EXIT in report"
> > > > +             perf kvm -i "${perfdata}" stat report 2>&1
> > > > +             err=3D1
> > > > +             return
> > > > +     fi
> > > > +
> > > > +     echo "perf kvm stat test [Success]"
> > > > +}
> > > > +
> > > > +test_kvm_record_report() {
> > > > +     echo "Testing perf kvm record/report"
> > > > +
> > > > +     echo "Recording kvm profile for pid ${qemu_pid}..."
> > > > +     # Use --host to avoid needing guest symbols/mounts for this s=
imple test
> > > > +     # We just want to verify the command runs and produces data
> > > > +     # We run in background and kill it because 'perf kvm record' =
appends options
> > > > +     # after the command, which breaks 'sleep' (e.g. it gets '-e c=
ycles').
> > > > +     perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
> > > > +     rec_pid=3D$!
> > > > +     sleep 1
> > > > +     kill -INT "${rec_pid}"
> > > > +     wait "${rec_pid}" || true
> > > > +
> > > > +     echo "Reporting kvm profile..."
> > > > +     # Check for some standard output from report
> > > > +     if ! perf kvm -i "${perfdata}" report --stdio 2>&1 | grep -q =
"Event count"; then
> > > > +             echo "Failed to report kvm profile"
> > > > +             perf kvm -i "${perfdata}" report --stdio 2>&1
> > > > +             err=3D1
> > > > +             return
> > > > +     fi
> > > > +
> > > > +     echo "perf kvm record/report test [Success]"
> > > > +}
> > > > +
> > > > +test_kvm_buildid_list() {
> > > > +     echo "Testing perf kvm buildid-list"
> > > > +
> > > > +     # We reuse the perf.data from the previous record test
> > > > +     if ! perf kvm --host -i "${perfdata}" buildid-list 2>&1 | gre=
p -q "."; then
> > > > +             echo "Failed to list buildids"
> > > > +             perf kvm --host -i "${perfdata}" buildid-list 2>&1
> > > > +             err=3D1
> > > > +             return
> > > > +     fi
> > > > +
> > > > +     echo "perf kvm buildid-list test [Success]"
> > > > +}
> > > > +
> > > > +setup_qemu() {
> > > > +     # Find qemu
> > > > +     if [ "$(uname -m)" =3D "x86_64" ]; then
> > > > +             qemu=3D"qemu-system-x86_64"
> > > > +     elif [ "$(uname -m)" =3D "aarch64" ]; then
> > > > +             qemu=3D"qemu-system-aarch64"
> > > > +     elif [ "$(uname -m)" =3D "s390x" ]; then
> > > > +             qemu=3D"qemu-system-s390x"
> > > > +     elif [ "$(uname -m)" =3D "ppc64le" ]; then
> > > > +             qemu=3D"qemu-system-ppc64"
> > > > +     else
> > > > +             qemu=3D"qemu-system-$(uname -m)"
> > > > +     fi
> > > > +
> > > > +     if ! which -s "$qemu"; then
> > > > +             skip "$qemu not found"
> > > > +     fi
> > > > +
> > > > +     if [ ! -r /dev/kvm ] || [ ! -w /dev/kvm ]; then
> > > > +             skip "/dev/kvm not accessible"
> > > > +     fi
> > > > +
> > > > +     if ! perf kvm stat record -a sleep 0.01 >/dev/null 2>&1; then
> > > > +             skip "No permission to record kvm events"
> > > > +     fi
> > > > +
> > > > +     echo "Starting $qemu..."
> > > > +     # Start qemu in background, detached, with pidfile
> > > > +     # We use -display none -daemonize and a monitor to keep it al=
ive/controllable if needed
> > > > +     # We don't need a real kernel, just KVM active.
> > > > +     if ! $qemu -enable-kvm -display none -daemonize -pidfile "${q=
emu_pid_file}" -monitor none; then
> > >
> > > What is running in the guest?
> >
> > Nothing. As no kernel or storage image were provided the guest should
> > be waiting at the bios similar to if you booted a PC with no storage
> > in it. I just wanted something quick and dirty to give the basic perf
> > kvm command a simple work out for the sake of testing coverage.
>
> Ok, it'd be fine as long as perf can get some samples in the guest.

I hope we always get a sample in the guest, but I don't think it is a
given as qemu is running in the background, etc. Even without guest
samples the code is getting coverage in the perf tool we don't get by
other means, for example, finding the broken BUG_ON.

Thanks,
Ian

> Thanks,
> Namhyung
>
