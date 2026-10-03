Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B7F3F9264;
	Sat,  3 Oct 2026 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791020160; cv=none; b=C4pua0Vnv+2GbjbDYsmNRmeXQ5xb7EXWiWatGlKG+CTxo5sdSpy7cy2tJboDJfnQ+MQyvzogfwJXLlAuvfnfUhXNxyvaydYJNQAyT7H8Z9aMWiXUb3R7FAzobT5g8xLLvugp0kDk1e5Wgk3n3MiAgKtq8YakbGwSDa19vfJiOtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791020160; c=relaxed/simple;
	bh=euGgRr62l+jXN1ud+5CYZz90C6i6h78D5b6Ef/5RB+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYyNttdTB2K0s/UBMSOH8oHI+miLj3cUUAXhUCRxAuZOp0h6xErkOo6vnoEYk1xP8ZQxVWhsIDvfZ4yhY52NcKcjQ2N3ZS2RTXtrdFwQvVWzEt2unTs5EEPVS9/HhBivdE6qVC+i+0Afu5BG6YdqeEMgb5gjVqH/Dvfbb04gLQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNLu8Zam; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNLu8Zam"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8FB1F0089B;
	Sat,  3 Oct 2026 09:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791020156;
	bh=P9h5jkFg9wPDKLALCrLAZac+jzb4KvaSwjrCb7YK1oY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XNLu8ZamK3vbN0Ze+udMM3lEPncLh3gXn6TfNHiSXU5kfvWXI8PRmOLrnotDOr+su
	 5hyBxVB5pkVF+Yg4RGv3fQjrbox4tlQdnlu012zJP1RiNKgw/uv7Fy+pEcB34aLgat
	 9FIob5lu2WIlvdJGdx7daQnTeJ0XyAcTMN95ylwVSpSIv9osq1g8EKL43BF2s3Ylio
	 eplzZz69JXaoU0Pqg6zAPzs6pvkRNdiXQmTIacSlvw6VJmD18ANVEbSlQmBIni6NUA
	 SksOq3+hdLfGNiIfH7ymP+iFh6FsDIafiiEBMtt+PkpcDwKGbHoBCTIC5OEjApRajL
	 3f2uH6CRQ7o0Q==
Date: Sat, 3 Oct 2026 11:35:44 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Alice Rogers <alice.mei.rogers@gmail.com>,
	Changbin Du <changbin.du@huawei.com>,
	Tengda Wu <wutengda@huaweicloud.com>, tanze <tanze@kylinos.cn>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 09/13] perf test: Add a test for the treport script
Message-ID: <asDMcH6oLeO4ABTS@x2>
References: <20261002182624.3259797-1-irogers@google.com>
 <20261002182624.3259797-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002182624.3259797-10-irogers@google.com>

On Fri, Oct 02, 2026 at 11:26:18AM -0700, Ian Rogers wrote:
> From: Alice Rogers <alice.mei.rogers@gmail.com>
> 
> Test launching treport through perf script, the error for a file that
> isn't a perf.data file, drive the textual app headless checking the
> profile matches one built without the UI and exercising the key
> bindings, and that quitting while loading stops the background load.

+        tabs.active = "flame"
+        await pilot.pause()
+        await pilot.press("down", "down", "right", "enter", "escape", "up", "left")
+        await pilot.pause()
+        print("headless UI ok")

This is super great, testing a TUI app in 'perf test', well done.

- Arnaldo
 
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Alice Rogers <alice.mei.rogers@gmail.com>
> Co-developed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/shell/test_treport_python.sh | 247 ++++++++++++++++++
>  1 file changed, 247 insertions(+)
>  create mode 100755 tools/perf/tests/shell/test_treport_python.sh
> 
> diff --git a/tools/perf/tests/shell/test_treport_python.sh b/tools/perf/tests/shell/test_treport_python.sh
> new file mode 100755
> index 000000000000..155993b8be79
> --- /dev/null
> +++ b/tools/perf/tests/shell/test_treport_python.sh
> @@ -0,0 +1,247 @@
> +#!/bin/bash
> +# perf script treport test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +shelldir=$(dirname "$0")
> +# shellcheck source=lib/setup_python.sh
> +. "${shelldir}"/lib/setup_python.sh
> +
> +if ! "$PYTHON" -c 'import perf' > /dev/null 2>&1; then
> +	echo "Skipping test, perf python module not found"
> +	exit 2
> +fi
> +
> +if ! "$PYTHON" -c 'import textual' > /dev/null 2>&1; then
> +	echo "Skipping test, python textual library not found"
> +	exit 2
> +fi
> +
> +err=0
> +perfdata=
> +output=
> +badfile=
> +
> +cleanup() {
> +	[ -n "${perfdata}" ] && rm -f "${perfdata}"*
> +	rm -f "${output}" "${badfile}"
> +	trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +	echo "Unexpected signal in ${FUNCNAME[1]}"
> +	cleanup
> +	exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +perfdata=$(mktemp /tmp/__perf_treport_test.perf.data.XXXXX)
> +output=$(mktemp /tmp/__perf_treport_test.output.XXXXX)
> +badfile=$(mktemp /tmp/__perf_treport_test.bad.XXXXX)
> +
> +test_plumbing() {
> +	echo "treport plumbing test"
> +	# A missing input file should be reported by the script launched
> +	# through perf script, this doesn't need a terminal.
> +	if perf script treport -i "${perfdata}.missing" > "${output}" 2>&1; then
> +		echo "treport plumbing test [Failed: missing file not an error]"
> +		err=1
> +		return
> +	fi
> +	if ! grep -q "not found" "${output}"; then
> +		echo "treport plumbing test [Failed: script not launched]"
> +		cat "${output}"
> +		err=1
> +		return
> +	fi
> +	echo "treport plumbing test [Success]"
> +}
> +
> +test_bad_file() {
> +	echo "treport bad file test"
> +	echo "not a perf.data file" > "${badfile}"
> +	# The app starts before the file is read, so the error is reported by
> +	# the app exiting with a failure.
> +	if ! "$PYTHON" - "${badfile}" > "${output}" 2>&1 <<'EOF'
> +import asyncio
> +import sys
> +import treport
> +
> +async def run() -> None:
> +    app = treport.ReportApp(sys.argv[1])
> +    async with app.run_test(size=(120, 40)) as pilot:
> +        for _ in range(100):
> +            if app.return_code is not None:
> +                break
> +            await pilot.pause(0.1)
> +    if app.return_code != 1:
> +        raise RuntimeError(f"Unexpected return code {app.return_code}")
> +    print("bad file ok")
> +
> +asyncio.run(run())
> +EOF
> +	then
> +		echo "treport bad file test [Failed: exception]"
> +		cat "${output}"
> +		err=1
> +		return
> +	fi
> +	if ! grep -q "bad file ok" "${output}"; then
> +		echo "treport bad file test [Failed: unexpected output]"
> +		cat "${output}"
> +		err=1
> +		return
> +	fi
> +	echo "treport bad file test [Success]"
> +}
> +
> +record() {
> +	# A software event with callchains that doesn't need privileges.
> +	perf record -e task-clock -g -o "${perfdata}" -- perf test -w noploop \
> +		> /dev/null 2>&1
> +}
> +
> +test_headless_ui() {
> +	echo "treport headless UI test"
> +	# Drive the textual app without a terminal, check the profile shown
> +	# matches one built without the UI and exercise the key bindings.
> +	if ! "$PYTHON" - "${perfdata}" > "${output}" 2>&1 <<'EOF'
> +import asyncio
> +import sys
> +import treport
> +
> +def labels(tree, tnode, out):
> +    for child in tnode.children:
> +        out.append(str(child.label))
> +        if child.is_expanded:
> +            labels(tree, child, out)
> +    return out
> +
> +async def run() -> None:
> +    expected = treport.ProfileBuilder()
> +    expected.read(sys.argv[1])
> +    if not expected.root.children:
> +        raise RuntimeError("No samples in the profile")
> +
> +    # The app starts before the profile is built in a background thread.
> +    app = treport.ReportApp(sys.argv[1])
> +    async with app.run_test(size=(120, 40)) as pilot:
> +        for _ in range(600):
> +            if app.loaded:
> +                break
> +            await pilot.pause(0.1)
> +        if not app.loaded:
> +            raise RuntimeError("Timed out loading data")
> +        await pilot.pause()
> +        if app.sub_title.startswith("Loading") or "samples" not in app.sub_title:
> +            raise RuntimeError(f"Unexpected sub-title: {app.sub_title}")
> +        totals = {name: node.value for name, node in app.root.children.items()}
> +        want = {name: node.value for name, node in expected.root.children.items()}
> +        if totals != want:
> +            raise RuntimeError(f"Profile {totals} differs from {want}")
> +        tree = app.query_one(treport.ProfileTree)
> +        shown = labels(tree, tree.root, [])
> +        if not any("noploop" in label for label in shown):
> +            raise RuntimeError(f"noploop not shown in: {shown}")
> +        await pilot.press("down", "down", "enter", "up", "enter")
> +        tabs = app.query_one(treport.TabbedContent)
> +        tabs.active = "flame"
> +        await pilot.pause()
> +        await pilot.press("down", "down", "right", "enter", "escape", "up", "left")
> +        await pilot.pause()
> +        print("headless UI ok")
> +
> +asyncio.run(run())
> +EOF
> +	then
> +		echo "treport headless UI test [Failed: exception]"
> +		cat "${output}"
> +		err=1
> +		return
> +	fi
> +	if ! grep -q "headless UI ok" "${output}"; then
> +		echo "treport headless UI test [Failed: unexpected output]"
> +		cat "${output}"
> +		err=1
> +		return
> +	fi
> +	echo "treport headless UI test [Success]"
> +}
> +
> +test_cancel() {
> +	echo "treport cancel test"
> +	# Quitting while loading should stop the background thread without a
> +	# "processing failed" error from the session.
> +	if ! "$PYTHON" - "${perfdata}" > "${output}" 2>&1 <<'EOF'
> +import asyncio
> +import sys
> +import time
> +import treport
> +
> +# Check for cancellation often and slow processing each sample so that the
> +# load can't finish before it is cancelled.
> +treport.ProfileBuilder.PROGRESS_INTERVAL = 1
> +process_event = treport.ProfileBuilder.process_event
> +
> +def slow_process_event(self, sample) -> None:
> +    time.sleep(0.001)
> +    process_event(self, sample)
> +
> +treport.ProfileBuilder.process_event = slow_process_event
> +
> +async def run() -> None:
> +    app = treport.ReportApp(sys.argv[1])
> +    async with app.run_test(size=(120, 40)) as pilot:
> +        for _ in range(100):
> +            loading = app.loading
> +            if loading is not None and loading.nr_samples > 0:
> +                break
> +            await pilot.pause(0.1)
> +        if loading is None or app.loaded:
> +            raise RuntimeError("Background load not in progress")
> +        await pilot.press("ctrl+q")
> +    for _ in range(100):
> +        if app.loading is None:
> +            break
> +        time.sleep(0.1)
> +    if app.loading is not None:
> +        raise RuntimeError("Background load didn't stop")
> +    if not loading.cancelled or app.loaded:
> +        raise RuntimeError("Background load wasn't cancelled")
> +    print("cancel ok")
> +
> +asyncio.run(run())
> +EOF
> +	then
> +		echo "treport cancel test [Failed: exception]"
> +		cat "${output}"
> +		err=1
> +		return
> +	fi
> +	if ! grep -q "cancel ok" "${output}" || grep -q "processing failed" "${output}"; then
> +		echo "treport cancel test [Failed: unexpected output]"
> +		cat "${output}"
> +		err=1
> +		return
> +	fi
> +	echo "treport cancel test [Success]"
> +}
> +
> +test_plumbing
> +test_bad_file
> +
> +if ! record; then
> +	echo "Skipping remaining tests, failed to record samples"
> +	if [ $err -eq 0 ]; then
> +		err=2
> +	fi
> +	cleanup
> +	exit $err
> +fi
> +
> +test_headless_ui
> +test_cancel
> +
> +cleanup
> +exit $err
> -- 
> 2.56.0.rc1.315.gc6ed9934b7-goog
