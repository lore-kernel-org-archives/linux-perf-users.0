Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2429931D75E;
	Wed,  3 Dec 2025 19:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764788609; cv=none; b=kZgKpLhnMklQM8uNe3izDpkyXCBWooBHuJm75/Z1exqgGdlkuwHvYlk2hQblTY5G30+JHD/HpEaDWyIZesgPidejD3R/51OPLFtbvDEGgu+5YY+wzwApRvHCjU9IWZHC4oIrHnkzyv277LQMSXMQVqQpgFSrHniSQT/r8FEOOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764788609; c=relaxed/simple;
	bh=dg4A2C8FQTivEf2xtNiQT7aKPmVpgfnLS3cf0DKYYaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMClnAPE9ID2+dN1OoTdCYbMXw/zz3nDuCitaDw8Zzv6Jmuvfd/qcDje/WOxmzyS3eONB3v5Uf1VB1FFPbGhgJYG6dbn5OQYANx2fUS+1BsFPETTXYLaxIKdKIz8I8JB4HlVecvxdRsgN+55j6qR1SUq5uwYhLiWK6YyCCnj+gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOQ6mWjV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOQ6mWjV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD997C4CEF5;
	Wed,  3 Dec 2025 19:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764788608;
	bh=dg4A2C8FQTivEf2xtNiQT7aKPmVpgfnLS3cf0DKYYaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JOQ6mWjV2rBeLPa4Na/UQzCDJ2IBIYYrK9siFSFb9R/QjNaEAcWdv2epGkfyBSfGv
	 2KRhAb9Hi8kKAO1Qxr8Vs/S5v9Z5FkQZFz9q9l3fP0uxDr1YJtRuq+6jW0Y57GvAS9
	 bRiZhcLPW5oB2lVdJmn3mWdJ/wyfx9HUTYz6jidRhZMEIHdrxWi6Mg1xoMLGp82LoN
	 dIjTn1B0eyyfARknndFYMgLgvaiJyejg4G5SOKSrEDPLRMG4y4nnDCh0/L0h89Hhgw
	 +jl2OgiRv9D9PTSCueeMZxBVoguYGToItYtxArrsCHMJioBdjPJTCOcB+36EZIQgq6
	 qON9c4y4A2ECA==
Date: Wed, 3 Dec 2025 11:03:25 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Collin Funk <collin.funk1@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>, Leo Yan <leo.yan@arm.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Stephen Brennan <stephen.s.brennan@oracle.com>,
	Haibo Xu <haibo1.xu@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 17/17] perf test kvm: Add some basic perf kvm test
 coverage
Message-ID: <aTCJfchgvoT1Zo_d@google.com>
References: <20251122081929.7588-1-irogers@google.com>
 <20251122081929.7588-18-irogers@google.com>
 <aSaqhlvclSnzJJf1@google.com>
 <CAP-5=fVW0Hnf6SfuAC4q-bZtr7h7XkYpQrGLQVj6rXc4Ddh5fQ@mail.gmail.com>
 <aSi6uGZdIqxLuyhz@google.com>
 <CAP-5=fWrbHu75NZcYn7NETDb057uZA6NGpOFADMWNgHRyxfCsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWrbHu75NZcYn7NETDb057uZA6NGpOFADMWNgHRyxfCsA@mail.gmail.com>

On Fri, Nov 28, 2025 at 01:06:22AM -0800, Ian Rogers wrote:
> On Thu, Nov 27, 2025 at 12:55 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Nov 27, 2025 at 03:53:13AM -0800, Ian Rogers wrote:
> > > On Tue, Nov 25, 2025 at 11:21 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > On Sat, Nov 22, 2025 at 12:19:29AM -0800, Ian Rogers wrote:
> > > > > Setup qemu with KVM then run kvm stat and some host
> > > > > recording/reporting/build-id tests.
> > > > >
> > > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > > ---
> > > > >  tools/perf/tests/shell/kvm.sh | 154 ++++++++++++++++++++++++++++++++++
> > > > >  1 file changed, 154 insertions(+)
> > > > >  create mode 100755 tools/perf/tests/shell/kvm.sh
> > > > >
> > > > > diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
> > > > > new file mode 100755
> > > > > index 000000000000..2fafde1a29cc
> > > > > --- /dev/null
> > > > > +++ b/tools/perf/tests/shell/kvm.sh
> > > > > @@ -0,0 +1,154 @@
> > > > > +#!/bin/bash
> > > > > +# perf kvm tests
> > > > > +# SPDX-License-Identifier: GPL-2.0
> > > > > +
> > > > > +set -e
> > > > > +
> > > > > +err=0
> > > > > +perfdata=$(mktemp /tmp/__perf_kvm_test.perf.data.XXXXX)
> > > > > +qemu_pid_file=$(mktemp /tmp/__perf_kvm_test.qemu.pid.XXXXX)
> > > > > +
> > > > > +cleanup() {
> > > > > +     rm -f "${perfdata}"
> > > > > +     if [ -f "${qemu_pid_file}" ]; then
> > > > > +             if [ -s "${qemu_pid_file}" ]; then
> > > > > +                     qemu_pid=$(cat "${qemu_pid_file}")
> > > > > +                     if [ -n "${qemu_pid}" ]; then
> > > > > +                             kill "${qemu_pid}" 2>/dev/null || true
> > > > > +                     fi
> > > > > +             fi
> > > > > +             rm -f "${qemu_pid_file}"
> > > > > +     fi
> > > > > +     trap - EXIT TERM INT
> > > > > +}
> > > > > +
> > > > > +trap_cleanup() {
> > > > > +     echo "Unexpected signal in ${FUNCNAME[1]}"
> > > > > +     cleanup
> > > > > +     exit 1
> > > > > +}
> > > > > +trap trap_cleanup EXIT TERM INT
> > > > > +
> > > > > +skip() {
> > > > > +     echo "Skip: $1"
> > > > > +     cleanup
> > > > > +     exit 2
> > > > > +}
> > > > > +
> > > > > +test_kvm_stat() {
> > > > > +     echo "Testing perf kvm stat"
> > > > > +
> > > > > +     echo "Recording kvm events for pid ${qemu_pid}..."
> > > > > +     if ! perf kvm stat record -p "${qemu_pid}" -o "${perfdata}" sleep 1; then
> > > > > +             echo "Failed to record kvm events"
> > > > > +             err=1
> > > > > +             return
> > > > > +     fi
> > > > > +
> > > > > +     echo "Reporting kvm events..."
> > > > > +     if ! perf kvm -i "${perfdata}" stat report 2>&1 | grep -q "VM-EXIT"; then
> > > > > +             echo "Failed to find VM-EXIT in report"
> > > > > +             perf kvm -i "${perfdata}" stat report 2>&1
> > > > > +             err=1
> > > > > +             return
> > > > > +     fi
> > > > > +
> > > > > +     echo "perf kvm stat test [Success]"
> > > > > +}
> > > > > +
> > > > > +test_kvm_record_report() {
> > > > > +     echo "Testing perf kvm record/report"
> > > > > +
> > > > > +     echo "Recording kvm profile for pid ${qemu_pid}..."
> > > > > +     # Use --host to avoid needing guest symbols/mounts for this simple test
> > > > > +     # We just want to verify the command runs and produces data
> > > > > +     # We run in background and kill it because 'perf kvm record' appends options
> > > > > +     # after the command, which breaks 'sleep' (e.g. it gets '-e cycles').
> > > > > +     perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
> > > > > +     rec_pid=$!
> > > > > +     sleep 1
> > > > > +     kill -INT "${rec_pid}"
> > > > > +     wait "${rec_pid}" || true
> > > > > +
> > > > > +     echo "Reporting kvm profile..."
> > > > > +     # Check for some standard output from report
> > > > > +     if ! perf kvm -i "${perfdata}" report --stdio 2>&1 | grep -q "Event count"; then
> > > > > +             echo "Failed to report kvm profile"
> > > > > +             perf kvm -i "${perfdata}" report --stdio 2>&1
> > > > > +             err=1
> > > > > +             return
> > > > > +     fi
> > > > > +
> > > > > +     echo "perf kvm record/report test [Success]"
> > > > > +}
> > > > > +
> > > > > +test_kvm_buildid_list() {
> > > > > +     echo "Testing perf kvm buildid-list"
> > > > > +
> > > > > +     # We reuse the perf.data from the previous record test
> > > > > +     if ! perf kvm --host -i "${perfdata}" buildid-list 2>&1 | grep -q "."; then
> > > > > +             echo "Failed to list buildids"
> > > > > +             perf kvm --host -i "${perfdata}" buildid-list 2>&1
> > > > > +             err=1
> > > > > +             return
> > > > > +     fi
> > > > > +
> > > > > +     echo "perf kvm buildid-list test [Success]"
> > > > > +}
> > > > > +
> > > > > +setup_qemu() {
> > > > > +     # Find qemu
> > > > > +     if [ "$(uname -m)" = "x86_64" ]; then
> > > > > +             qemu="qemu-system-x86_64"
> > > > > +     elif [ "$(uname -m)" = "aarch64" ]; then
> > > > > +             qemu="qemu-system-aarch64"
> > > > > +     elif [ "$(uname -m)" = "s390x" ]; then
> > > > > +             qemu="qemu-system-s390x"
> > > > > +     elif [ "$(uname -m)" = "ppc64le" ]; then
> > > > > +             qemu="qemu-system-ppc64"
> > > > > +     else
> > > > > +             qemu="qemu-system-$(uname -m)"
> > > > > +     fi
> > > > > +
> > > > > +     if ! which -s "$qemu"; then
> > > > > +             skip "$qemu not found"
> > > > > +     fi
> > > > > +
> > > > > +     if [ ! -r /dev/kvm ] || [ ! -w /dev/kvm ]; then
> > > > > +             skip "/dev/kvm not accessible"
> > > > > +     fi
> > > > > +
> > > > > +     if ! perf kvm stat record -a sleep 0.01 >/dev/null 2>&1; then
> > > > > +             skip "No permission to record kvm events"
> > > > > +     fi
> > > > > +
> > > > > +     echo "Starting $qemu..."
> > > > > +     # Start qemu in background, detached, with pidfile
> > > > > +     # We use -display none -daemonize and a monitor to keep it alive/controllable if needed
> > > > > +     # We don't need a real kernel, just KVM active.
> > > > > +     if ! $qemu -enable-kvm -display none -daemonize -pidfile "${qemu_pid_file}" -monitor none; then
> > > >
> > > > What is running in the guest?
> > >
> > > Nothing. As no kernel or storage image were provided the guest should
> > > be waiting at the bios similar to if you booted a PC with no storage
> > > in it. I just wanted something quick and dirty to give the basic perf
> > > kvm command a simple work out for the sake of testing coverage.
> >
> > Ok, it'd be fine as long as perf can get some samples in the guest.
> 
> I hope we always get a sample in the guest, but I don't think it is a
> given as qemu is running in the background, etc. Even without guest
> samples the code is getting coverage in the perf tool we don't get by
> other means, for example, finding the broken BUG_ON.

Fair enough.  We can update it later if needed.

Thanks,
Namhyung

