Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E1A2405E1;
	Thu, 27 Nov 2025 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764276922; cv=none; b=rlA354du3zcgmW1eN0iuGLi46AiGRzPFbO3hDmNMuD7s4flBph9ySw4vFwOcgwyJYfWx1EmYfhL9m4zi7FvJqkrBasTKmgZryEUQt0OEVCEyNAYqtNehfdAV1TN4PMbHguETzONR46gPKTyDDuFCYUIqRYch1sv4qf7AMm1I/xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764276922; c=relaxed/simple;
	bh=4J+3KySOP0BSmml1pvDiAb791ucpuDXHLMrfOiv7jsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zil3xDJGBZ5FyfDp02unlVgNy9tdAxgMgDlW3vXI76vwtyjCSbdNT9pZZOuyrqRm8UCh5+ERuPu6bCetP9Wp/QfZcwxiIriXd4hAEylM5ZpqMaD/OvgYE96hFjFJOwOyISlxhKbExuW4/Z1vp4cAFJznJQ/X//jQc8MiZ1gSuiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oazVXzOd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oazVXzOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6597FC4CEF8;
	Thu, 27 Nov 2025 20:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764276922;
	bh=4J+3KySOP0BSmml1pvDiAb791ucpuDXHLMrfOiv7jsI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oazVXzOdoc4tqu2lpWaoya2zJdI+5SjBFvFoMPV+WgGc8yrrRNvxId68AsGhyvsGn
	 vLALBg+6psZOZYNPy3+VJt7L30A7xQiPF5fkFhcLdBnvaiQhn+u1FkWRl4MlCWjXOg
	 9YkHw0KbTACd/u+eRsmSKmzsqmQMyJMP2IVdw8btLJan6lf8jkBTWob9nqkHwWFzBd
	 li2LRteJTsABjUkVYjMnHe9RAdLE1fw2E2jfTD8qQpNIvXzK7CPACY2mAlOzcO8fle
	 4zM2DCW19uajVH7K250q99/HsC+lhDXJeKBATAQ9kKj1U+YbaNxbH/CJ3qT1rLSzTL
	 5o+1x8Y3HorQQ==
Date: Thu, 27 Nov 2025 12:55:20 -0800
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
Message-ID: <aSi6uGZdIqxLuyhz@google.com>
References: <20251122081929.7588-1-irogers@google.com>
 <20251122081929.7588-18-irogers@google.com>
 <aSaqhlvclSnzJJf1@google.com>
 <CAP-5=fVW0Hnf6SfuAC4q-bZtr7h7XkYpQrGLQVj6rXc4Ddh5fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVW0Hnf6SfuAC4q-bZtr7h7XkYpQrGLQVj6rXc4Ddh5fQ@mail.gmail.com>

On Thu, Nov 27, 2025 at 03:53:13AM -0800, Ian Rogers wrote:
> On Tue, Nov 25, 2025 at 11:21 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Sat, Nov 22, 2025 at 12:19:29AM -0800, Ian Rogers wrote:
> > > Setup qemu with KVM then run kvm stat and some host
> > > recording/reporting/build-id tests.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/tests/shell/kvm.sh | 154 ++++++++++++++++++++++++++++++++++
> > >  1 file changed, 154 insertions(+)
> > >  create mode 100755 tools/perf/tests/shell/kvm.sh
> > >
> > > diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
> > > new file mode 100755
> > > index 000000000000..2fafde1a29cc
> > > --- /dev/null
> > > +++ b/tools/perf/tests/shell/kvm.sh
> > > @@ -0,0 +1,154 @@
> > > +#!/bin/bash
> > > +# perf kvm tests
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +
> > > +set -e
> > > +
> > > +err=0
> > > +perfdata=$(mktemp /tmp/__perf_kvm_test.perf.data.XXXXX)
> > > +qemu_pid_file=$(mktemp /tmp/__perf_kvm_test.qemu.pid.XXXXX)
> > > +
> > > +cleanup() {
> > > +     rm -f "${perfdata}"
> > > +     if [ -f "${qemu_pid_file}" ]; then
> > > +             if [ -s "${qemu_pid_file}" ]; then
> > > +                     qemu_pid=$(cat "${qemu_pid_file}")
> > > +                     if [ -n "${qemu_pid}" ]; then
> > > +                             kill "${qemu_pid}" 2>/dev/null || true
> > > +                     fi
> > > +             fi
> > > +             rm -f "${qemu_pid_file}"
> > > +     fi
> > > +     trap - EXIT TERM INT
> > > +}
> > > +
> > > +trap_cleanup() {
> > > +     echo "Unexpected signal in ${FUNCNAME[1]}"
> > > +     cleanup
> > > +     exit 1
> > > +}
> > > +trap trap_cleanup EXIT TERM INT
> > > +
> > > +skip() {
> > > +     echo "Skip: $1"
> > > +     cleanup
> > > +     exit 2
> > > +}
> > > +
> > > +test_kvm_stat() {
> > > +     echo "Testing perf kvm stat"
> > > +
> > > +     echo "Recording kvm events for pid ${qemu_pid}..."
> > > +     if ! perf kvm stat record -p "${qemu_pid}" -o "${perfdata}" sleep 1; then
> > > +             echo "Failed to record kvm events"
> > > +             err=1
> > > +             return
> > > +     fi
> > > +
> > > +     echo "Reporting kvm events..."
> > > +     if ! perf kvm -i "${perfdata}" stat report 2>&1 | grep -q "VM-EXIT"; then
> > > +             echo "Failed to find VM-EXIT in report"
> > > +             perf kvm -i "${perfdata}" stat report 2>&1
> > > +             err=1
> > > +             return
> > > +     fi
> > > +
> > > +     echo "perf kvm stat test [Success]"
> > > +}
> > > +
> > > +test_kvm_record_report() {
> > > +     echo "Testing perf kvm record/report"
> > > +
> > > +     echo "Recording kvm profile for pid ${qemu_pid}..."
> > > +     # Use --host to avoid needing guest symbols/mounts for this simple test
> > > +     # We just want to verify the command runs and produces data
> > > +     # We run in background and kill it because 'perf kvm record' appends options
> > > +     # after the command, which breaks 'sleep' (e.g. it gets '-e cycles').
> > > +     perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
> > > +     rec_pid=$!
> > > +     sleep 1
> > > +     kill -INT "${rec_pid}"
> > > +     wait "${rec_pid}" || true
> > > +
> > > +     echo "Reporting kvm profile..."
> > > +     # Check for some standard output from report
> > > +     if ! perf kvm -i "${perfdata}" report --stdio 2>&1 | grep -q "Event count"; then
> > > +             echo "Failed to report kvm profile"
> > > +             perf kvm -i "${perfdata}" report --stdio 2>&1
> > > +             err=1
> > > +             return
> > > +     fi
> > > +
> > > +     echo "perf kvm record/report test [Success]"
> > > +}
> > > +
> > > +test_kvm_buildid_list() {
> > > +     echo "Testing perf kvm buildid-list"
> > > +
> > > +     # We reuse the perf.data from the previous record test
> > > +     if ! perf kvm --host -i "${perfdata}" buildid-list 2>&1 | grep -q "."; then
> > > +             echo "Failed to list buildids"
> > > +             perf kvm --host -i "${perfdata}" buildid-list 2>&1
> > > +             err=1
> > > +             return
> > > +     fi
> > > +
> > > +     echo "perf kvm buildid-list test [Success]"
> > > +}
> > > +
> > > +setup_qemu() {
> > > +     # Find qemu
> > > +     if [ "$(uname -m)" = "x86_64" ]; then
> > > +             qemu="qemu-system-x86_64"
> > > +     elif [ "$(uname -m)" = "aarch64" ]; then
> > > +             qemu="qemu-system-aarch64"
> > > +     elif [ "$(uname -m)" = "s390x" ]; then
> > > +             qemu="qemu-system-s390x"
> > > +     elif [ "$(uname -m)" = "ppc64le" ]; then
> > > +             qemu="qemu-system-ppc64"
> > > +     else
> > > +             qemu="qemu-system-$(uname -m)"
> > > +     fi
> > > +
> > > +     if ! which -s "$qemu"; then
> > > +             skip "$qemu not found"
> > > +     fi
> > > +
> > > +     if [ ! -r /dev/kvm ] || [ ! -w /dev/kvm ]; then
> > > +             skip "/dev/kvm not accessible"
> > > +     fi
> > > +
> > > +     if ! perf kvm stat record -a sleep 0.01 >/dev/null 2>&1; then
> > > +             skip "No permission to record kvm events"
> > > +     fi
> > > +
> > > +     echo "Starting $qemu..."
> > > +     # Start qemu in background, detached, with pidfile
> > > +     # We use -display none -daemonize and a monitor to keep it alive/controllable if needed
> > > +     # We don't need a real kernel, just KVM active.
> > > +     if ! $qemu -enable-kvm -display none -daemonize -pidfile "${qemu_pid_file}" -monitor none; then
> >
> > What is running in the guest?
> 
> Nothing. As no kernel or storage image were provided the guest should
> be waiting at the bios similar to if you booted a PC with no storage
> in it. I just wanted something quick and dirty to give the basic perf
> kvm command a simple work out for the sake of testing coverage.

Ok, it'd be fine as long as perf can get some samples in the guest.

Thanks,
Namhyung

