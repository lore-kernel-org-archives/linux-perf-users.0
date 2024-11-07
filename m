Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069522E3EB;
	Thu,  7 Nov 2024 14:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991129; cv=none; b=qk+sJfjLKxSUEPjEhTTpSXDElO6tGPrqz3o7MDyUbORcjqLG1HnFNB6JLv1HZWVkjruC3ibHr1nao7NcOspVGO2K2FrX7oBmUP1W/58CMlvZkm/6r5m+YH7TJa6QbQKVC3OGfFJkwcsFfXP/3OJgHASqpJrWCZT7TQ4MPP13cdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991129; c=relaxed/simple;
	bh=G5LiQgUodGnd2Y772yxyF+oeMYq3+OKZe8wt3Y9cMwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JwS9Wl+EFNhRB7Erlui2jV1kume8sAdnM1fZTFNeAhBo0BxHq67U24HSnLdOESjQTiwcFuDurOROoeBrq++8NKJv/L8Jol0zOVw0Oe6qj6nVFZGWR0nUvELhf6fTELoU+E2aqwkEbn2VANgT/1pS5Ynn8yQdunjLH/H+iYOUDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLPxg/VW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLPxg/VW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67ECC4CECC;
	Thu,  7 Nov 2024 14:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730991128;
	bh=G5LiQgUodGnd2Y772yxyF+oeMYq3+OKZe8wt3Y9cMwI=;
	h=From:To:Cc:Subject:Date:From;
	b=SLPxg/VWa4TB0CfyQE/Ow454DlFT9KdXmDLyDX7/nEjFk0C/0Z9ILjLtWhmIF+9Cu
	 C30Ek+tmKOgd4K7qAsfLg5KTPNFN/TTaPWIjgKdFbsVNRxUca4GNglJzz0OuCQAwF4
	 Ibsflz7/b9D+IyC6w2KKHkbxwd/6SJJMImvyO204iFH0WQYnB/hB8c1P7rrINRv9F4
	 gbD1NxXGmMb/u2uOEV4cvL2qThtJe9uEt250hy+sy1Q0eNBR5EB4ba9VGSdZuccrL/
	 TrrLwTNNFpxC7iEKGjx0PDiVXqYYH6PKs//jPXjqoBD9krKYWgSRR4FKlz/iF27H/4
	 +Jd6zh7dGtyTg==
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
Subject: [PATCH v2 0/6] perf-probe: Improbe non-C language support
Date: Thu,  7 Nov 2024 23:52:05 +0900
Message-ID:  <173099112488.2431889.1181692857521683304.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
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

Here is the 2nd version of patches for perf probe to improve non-C language
(e.g. Rust, Go) support. The previous version is here;

https://lore.kernel.org/all/173073702882.2098439.13342508872190995896.stgit@mhiramat.roam.corp.google.com/

In this version, Add a new error message [1/6], introduced `@*`
support[3/6], split str*_esq()[4/6], and use dwarf srclang to identify
the source code language[6/6].

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

Masami Hiramatsu (Google) (6):
      perf-probe: Fix error message for failing to find line range
      perf-probe: Fix to ignore escaped characters in --lines option
      perf-probe: Accept FUNC@* to specify function name explicitly
      perf: Add strpbrk_esq() and strdup_esq() for escape and quote
      perf-probe: Introduce quotation marks support
      perf-probe: Replace unacceptable characters when generating event name


 tools/perf/util/probe-event.c  |  135 ++++++++++++++++++++++++++++------------
 tools/perf/util/probe-event.h  |    3 +
 tools/perf/util/probe-finder.c |   15 ++++
 tools/perf/util/probe-finder.h |    6 +-
 tools/perf/util/string.c       |  100 ++++++++++++++++++++++++++++++
 tools/perf/util/string2.h      |    2 +
 6 files changed, 217 insertions(+), 44 deletions(-)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>
