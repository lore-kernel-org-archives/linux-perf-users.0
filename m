Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DFE20326;
	Mon,  4 Nov 2024 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737033; cv=none; b=uwR5KnK9N8WrIl5e6vSrkgv0k+JUKyTUMPodiZQWzT3aWIjZ5lZX0LZ45KFV7IRYwp2l5Ycg0SSFN36rlGtVmTeYRHpHI9T7XJorgr41cYopPI+jO6+efg6r5qEALXluHFsCqin8oj6DUDMv9aWLvSphv/RG+tuaip/VVbPE8Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737033; c=relaxed/simple;
	bh=Eh76YaHtmLt5DW3EPTo7cV6nWRKcIFXr4w4I1ezGAIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tpAfUNfg4cSXej1pSckQdoSfXS/Chu/mxoSd5sC5X11oo7oesEwsrXvlI/OSzwNJcJJk/3PzThNGd8fbZGryLakfMgn9JE2D6vtSiJVFuE+H5lZpBE1womy+6wkZBI2QX7PgErGaDbbgBJXRwCDMvWBe01Q9hjbVXKDXPrN6bZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t0uS4WQx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t0uS4WQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070BEC4CECE;
	Mon,  4 Nov 2024 16:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730737032;
	bh=Eh76YaHtmLt5DW3EPTo7cV6nWRKcIFXr4w4I1ezGAIc=;
	h=From:To:Cc:Subject:Date:From;
	b=t0uS4WQxZyWfsHKzntL/JOsbLcoUgwK7IxXNLpuJmgGCCbkdKffN6scYYHbUBRJ8b
	 0NwgxsZS4YAH+JiDqNa602sqAWP/bj1ToC3a0OR5E76efZYcB9/kBl4tepGj6+odMf
	 kb+VcqObQHls9mNwAvlyeDVJq1Ag3qN/hhguLelqk/VYPNF4V9Pe7at4c+Tbqfzrpe
	 +HbOjJz5yWimTRk14BuaLyPBm3Tu2Ra4R2UA760kL2gCMCJhEQTJvxfVcisICUet05
	 W9VRdRKfmaPk5FJzTbENorl+gp2DgQZ9fxlT2aFlW97nWIX84fOqtltbDR1xtDhHhL
	 ePBZeQbaYdofA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Dima Kogan <dima@secretsauce.net>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] perf-probe: Improbe non-C language support
Date: Tue,  5 Nov 2024 01:17:08 +0900
Message-ID:  <173073702882.2098439.13342508872190995896.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is a series of patches for perf probe to improve non-C language
(e.g. Rust, Go) support.

The non-C symbols are demangled style in debuginfo, e.g. golang stores

----
$ ./perf probe -x /work/go/example/outyet/main -F main*
main.(*Server).ServeHTTP
main.(*Server).ServeHTTP.Print.func1
main.(*Server).poll
...
-----

And Rust stores
-----
$ ./perf probe -x /work/cro3/target/x86_64-unknown-linux-gnu/debug/cro3 -F cro3::cmd::servo*
cro3::cmd::servo::run
cro3::cmd::servo::run::CALLSITE
cro3::cmd::servo::run::CALLSITE::META
cro3::cmd::servo::run_control
-----

These symbols are not parsed correctly because it looks like a file name or
including line numbers (`:` caused it.) So, I decided to introduce the changes

 - filename MUST start from '@'. (so it is able to distinguish the filename
   and the function name)
 - Fix to allow backslash to escape to --lines option.
 - Introduce quotation mark support.
 - Replace non-alnum character to '_' for event name (for non-C symbols).

With these changes, we can run -L (--lines) on golang;

------
$ perf probe -x goexample/hello/hello -L \"main.main\"
<main.main@/work/goexample/hello/hello.go:0>
      0  func main() {
                // Configure logging for a command-line program.
      2         log.SetFlags(0)
      3         log.SetPrefix("hello: ")

                // Parse flags.
      6         flag.Usage = usage
      7         flag.Parse()
------

And Rust
------
$ perf probe -x cro3 -L \"cro3::cmd::servo::run_show\"
<run_show@/work/cro3/src/cmd/servo.rs:0>
      0  fn run_show(args: &ArgsShow) -> Result<()> {
      1      let list = ServoList::discover()?;
      2      let s = list.find_by_serial(&args.servo)?;
      3      if args.json {
      4          println!("{s}");
------

And event name are created automatically like below;

$ ./perf probe -x /work/go/example/outyet/main -D 'main.(*Server).poll'
p:probe_main/main_Server_poll /work/go/example/outyet/main:0x353040

$ ./perf probe -x cro3 -D \"cro3::cmd::servo::run_show\"
p:probe_cro3/cro3_cmd_servo_run_show /work/cro3/target/x86_64-unknown-linux-gnu/debug/cro3:0x197530

We still need some more work, but these shows how perf-probe can work
with other languages.

Thank you,

---

Masami Hiramatsu (Google) (4):
      perf-probe: Fix to ignore escaped characters in --lines option
      perf-probe: Require '@' prefix for filename always
      perf-probe: Introduce quotation marks support
      perf-probe: Replace unacceptable characters when generating event name


 tools/perf/util/probe-event.c  |  136 ++++++++++++++++++++++------------------
 tools/perf/util/probe-finder.c |    3 +
 tools/perf/util/string.c       |  100 +++++++++++++++++++++++++++++
 tools/perf/util/string2.h      |    2 +
 4 files changed, 180 insertions(+), 61 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
