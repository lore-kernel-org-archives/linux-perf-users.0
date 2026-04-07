Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FB93314D2;
	Tue,  7 Apr 2026 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775566222; cv=none; b=GCPatp8mY4MYEkPiQfbmxZcawYjw9NTDrpLPTb/oc7lMoLBMoDZdbKvPc6HB1FmNHJSABioms1ywM+zEkvBg4fqcnHfsO+fqin/eOtgB3l8Ck6u8GecaiDjgcR/SkCRiFDG8Et8wdbXWxX8aIODmyUjNeSxAyMsIy4q5Sln8zm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775566222; c=relaxed/simple;
	bh=qUYqZ1sM4su7R3/u1xExFzzIEbPNUHGAS+oZvYupieg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZVN+Gtu8yZGue2FQwGOJw2dPgLK96l58I/aRa/f+s65ZLU2g05TlLvp/reriEQLtvSP4B8Zuy959xP7ePLAt2I7CijC+1yZpaFeCaPReCpXxKnZR0mLvdhRf+AsloJR9uMkf4HQEVq5XPgXjmhKDa2VhPb/lyCbtb88aTSK5hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coA0C2La; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coA0C2La"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D9AC116C6;
	Tue,  7 Apr 2026 12:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775566222;
	bh=qUYqZ1sM4su7R3/u1xExFzzIEbPNUHGAS+oZvYupieg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=coA0C2LaFFlEKyQm5cX7L8ifyMvsSCxBt6traGW33NQAbZZEp3h6KJB05d9gySbrS
	 jSM4DEdExcdyisaPzudSTUW3e9m0XXnKtwrD6v0wCnlVoh1mvd+hIgN2i0ALZQgm+S
	 Il46/PkgsYTk1OOyGuR//czhm7IxA5h/ylnsbmF6XXHqXXhtX5RWs+uxEAOykayLvP
	 7zVWl//kSFKDea6/24nwmiqPMuq18ILoxwN+v1iuXbmKfBKdESdaJXRWZI0AvSBKFS
	 OO1uY8jbMA2kcapJ++rBpYmaX8S6UeBrTkoS3IhxhWYxyAN8my9PXWx5eHrnxxb95k
	 u4RpinhZsDqbQ==
Date: Tue, 7 Apr 2026 09:50:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Guo Ren <guoren@kernel.org>, Howard Chu <howardchu95@gmail.com>,
	Ingo Molnar <mingo@redhat.com>, Leo Yan <leo.yan@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Yujie Liu <yujie.liu@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH 1/4] perf tools: Make more global variables static
Message-ID: <adT9iwnGImRtXLHa@x1>
References: <20260402001740.2220481-1-acme@kernel.org>
 <20260402001740.2220481-2-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260402001740.2220481-2-acme@kernel.org>

On Wed, Apr 01, 2026 at 09:17:37PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Ian Rogers <irogers@google.com>
> 
> `make check` will run sparse on the perf code base. A frequent warning
> is "warning: symbol '...' was not declared. Should it be static?" Go
> through and make global definitions without declarations static.
> 
> In some cases it is deliberate due to dlsym accessing the symbol, this
> change doesn't clean up the missing declarations for perf test suites.
> 
> Sometimes things can opportunistically be made const.
> 
> Making somethings static exposed unused functions warnings, so
> restructuring of ifdefs was necessary for that.
> 
> These changes reduce the size of the perf binary by 568 bytes.
> 
> Committer notes:
> 
> Refreshed the patch, the original one fell thru the cracks, updated the
> size reduction.
> 
> Remove the trace-event-scripting.c changes, break the build, noticed
> with container builds and with sashiko:
> 
>   https://sashiko.dev/#/patchset/20260401215306.2152898-1-acme%40kernel.org

Addressing a Sashiko review comment:

---
Does moving this array into the function without the static keyword force
unnecessary stack allocation and runtime initialization?
Since top_callchain_help[] is no longer static, the compiler might allocate
space on the stack and copy the contents from .rodata every time the function
is called. Using a pointer (const char *top_callchain_help) or keeping it
static const would prevent this overhead.
---

⬢ [acme@toolbx perf-tools-next]$ cat before
   text	   data	    bss	    dec	    hex	filename
12249047	 362081	  40040	12651168	 c10aa0	/home/acme/bin/perf
⬢ [acme@toolbx perf-tools-next]$ size ~/bin/perf
   text	   data	    bss	    dec	    hex	filename
12248983	 362081	  40040	12651104	 c10a60	/home/acme/bin/perf
⬢ [acme@toolbx perf-tools-next]$ git diff
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 35ff2495e1ee5897..f6eb543de537a3d3 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1451,7 +1451,7 @@ parse_percent_limit(const struct option *opt, const char *arg,

 int cmd_top(int argc, const char **argv)
 {
-       const char top_callchain_help[] = CALLCHAIN_RECORD_HELP CALLCHAIN_REPORT_HELP
+       static const char top_callchain_help[] = CALLCHAIN_RECORD_HELP CALLCHAIN_REPORT_HELP
                "\n\t\t\t\tDefault: fp,graph,0.5,caller,function";
        char errbuf[BUFSIZ];
        struct perf_top top = {
⬢ [acme@toolbx perf-tools-next]$

The second suggestion didn't make a difference, but lets keep it static
as well to ensure that is the case.

---
Is this also creating a stack-allocated array that requires initialization on
every call? Making distro_dwarf_types[] static const would ensure it stays
entirely in .rodata with zero runtime overhead.
---

⬢ [acme@toolbx perf-tools-next]$ cat before
   text	   data	    bss	    dec	    hex	filename
12248983	 362081	  40040	12651104	 c10a60	/home/acme/bin/perf
⬢ [acme@toolbx perf-tools-next]$ size ~/bin/perf
   text	   data	    bss	    dec	    hex	filename
12248983	 362081	  40040	12651104	 c10a60	/home/acme/bin/perf
⬢ [acme@toolbx perf-tools-next]$ git diff
diff --git a/tools/perf/util/debuginfo.c b/tools/perf/util/debuginfo.c
index 8b819dea36ac1ef0..0e35c13abd041c46 100644
--- a/tools/perf/util/debuginfo.c
+++ b/tools/perf/util/debuginfo.c
@@ -90,7 +90,7 @@ static struct debuginfo *__debuginfo__new(const char *path)

 struct debuginfo *debuginfo__new(const char *path)
 {
-       const enum dso_binary_type distro_dwarf_types[] = {
+       static const enum dso_binary_type distro_dwarf_types[] = {
                DSO_BINARY_TYPE__FEDORA_DEBUGINFO,
                DSO_BINARY_TYPE__UBUNTU_DEBUGINFO,
                DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO,
⬢ [acme@toolbx perf-tools-next]$

I'm adding these two changes and will resubmit, holler if you disagree.
:-)

- Arnaldo
