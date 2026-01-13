Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8839829E0F7;
	Tue, 13 Jan 2026 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315322; cv=none; b=Yo2vobC0zpVZ8dcH36qKhgxG+OkmyDhOgUXZ4fRNqth5ONq6bebAaBWQIi85rPjMYQ5mulZuHrF5JNvXw10EdH7CZo6ijLD1MVlR1HR4+4Ta7ET0pCZXkmBCJ0Se3JYeF71gZUqy17gHGY7CD0ngqladvHmwq/vhA/wNwSw1BzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315322; c=relaxed/simple;
	bh=6hMA6jS4aUELjQ5Z95gzXaxpnknDZ9XcW/J9ztvNWWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWG3BISvh2I0mBpzIvilX3uPM4YomiX00lCGUPUYXGlRkIAg207pGHjC5hD3KWUHwVVn6XZAp+inksxVYmm78FhO9F9sQneHmzspk5Q2GZpy6E++kXAs0mMAYdyasFnOhE7YPiozsDZUIoqm8K6LTN8mJdadhVE7bOGnzy/rg48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from gentoo.org (gentoo.cern.ch [IPv6:2001:1458:202:227::100:45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: amadio)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 2AFA2341050;
	Tue, 13 Jan 2026 14:41:58 +0000 (UTC)
Date: Tue, 13 Jan 2026 15:41:53 +0100
From: Guilherme Amadio <amadio@gentoo.org>
To: Ian Rogers <irogers@google.com>
Cc: "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf test subcmd help: Add exclude disjoint subcmd
 names
Message-ID: <aWZZsTdsiDKhlNa4@gentoo.org>
References: <20251208172339.1445817-1-irogers@google.com>
 <BY3PR17MB518624354091DB1B4FB7A7FCA5A1A@BY3PR17MB5186.namprd17.prod.outlook.com>
 <CAP-5=fXT=s7jnZwOK=HxWHAznjStrHvgZuJ9p62EGMNG1NYnqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXT=s7jnZwOK=HxWHAznjStrHvgZuJ9p62EGMNG1NYnqw@mail.gmail.com>

Dear Ian,

On Thu, Jan 08, 2026 at 11:27:51AM -0800, Ian Rogers wrote:
> On Wed, Dec 10, 2025 at 5:12 PM Jayaramappa, Srilakshmi
> <sjayaram@akamai.com> wrote:
> >
> >
> > ________________________________________
> > From: Ian Rogers <irogers@google.com>
> > Sent: Monday, December 8, 2025 9:23 AM
> > To: Jayaramappa, Srilakshmi; Guilherme Amadio; Peter Zijlstra; Ingo Molnar; Arnaldo Carvalho de Melo; Namhyung Kim; Alexander Shishkin; Jiri Olsa; Ian Rogers; Adrian Hunter; linux-perf-users@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [PATCH v1] perf test subcmd help: Add exclude disjoint subcmd names
> >
> > !-------------------------------------------------------------------|
> >   This Message Is From an External Sender
> >   This message came from outside your organization.
> > |-------------------------------------------------------------------!
> >
> > The test is based on an error/fix poseted to linux-perf-users.
> >
> > Reported-by: Sri Jayaramappa <sjayaram@akamai.com>
> > Closes: https://urldefense.com/v3/__https://lore.kernel.org/linux-perf-users/20251202213632.2873731-1-sjayaram@akamai.com/__;!!GjvTz_vk!XehekKNUE4Ib_tvqIH6PMIIhly4X3BZ-Y40RC1HKMQ-6OdYEFvUPQhyWv_gk9vsRRN4_RcOLS2Bh0CQ$
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/subcmd-help.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/tools/perf/tests/subcmd-help.c b/tools/perf/tests/subcmd-help.c
> > index 2280b4c0e5e7..9da96a16fd20 100644
> > --- a/tools/perf/tests/subcmd-help.c
> > +++ b/tools/perf/tests/subcmd-help.c
> > @@ -95,10 +95,36 @@ static int test__exclude_cmdnames(struct test_suite *test __maybe_unused,
> >         return TEST_OK;
> >  }
> >
> > +static int test__exclude_cmdnames_no_overlap(struct test_suite *test __maybe_unused,
> > +                                            int subtest __maybe_unused)
> > +{
> > +       struct cmdnames cmds1 = {};
> > +       struct cmdnames cmds2 = {};
> > +
> > +       add_cmdname(&cmds1, "read-vdso32", 11);
> > +       add_cmdname(&cmds2, "archive", 7);
> > +
> > +       TEST_ASSERT_VAL("invalid original size", cmds1.cnt == 1);
> > +       TEST_ASSERT_VAL("invalid original size", cmds2.cnt == 1);
> > +
> > +       exclude_cmds(&cmds1, &cmds2);
> > +
> > +       TEST_ASSERT_VAL("invalid excluded size", cmds1.cnt == 1);
> > +       TEST_ASSERT_VAL("invalid excluded size", cmds2.cnt == 1);
> > +
> > +       TEST_ASSERT_VAL("cannot find cmd", is_in_cmdlist(&cmds1, "read-vdso32") == 1);
> > +       TEST_ASSERT_VAL("wrong cmd", is_in_cmdlist(&cmds1, "archive") == 0);
> > +
> > +       clean_cmdnames(&cmds1);
> > +       clean_cmdnames(&cmds2);
> > +       return TEST_OK;
> > +}
> > +
> >  static struct test_case tests__subcmd_help[] = {
> >         TEST_CASE("Load subcmd names", load_cmdnames),
> >         TEST_CASE("Uniquify subcmd names", uniq_cmdnames),
> >         TEST_CASE("Exclude duplicate subcmd names", exclude_cmdnames),
> > +       TEST_CASE("Exclude disjoint subcmd names", exclude_cmdnames_no_overlap),
> >         {       .name = NULL, }
> >  };
> >
> > --
> > 2.52.0.223.gf5cc29aaa4-goog
> >
> >
> > Reviewed-by: Sri Jayaramappa <sjayaram@akamai.com>
> 
> Ping.

Assuming this is for me, I just tried the test and it correctly
fails for me on perf-tools-next (I applied the diff by hand, as it
didn't apply cleanly onto the commit below):

gentoo linux $ git log -1 --format=short
commit 75326c67aa8c43000819a2ac29f22eb27846d545 (HEAD -> perf-tools-next, perf-tools-next/tmp.perf-tools-next, perf-tools-next/perf-tools-next)
Author: Derek Foreman <derek.foreman@collabora.com>

    perf data: Fix coding style
gentoo linux $ tools/perf/perf version
perf version 6.19.rc4.g75326c67aa8c
gentoo linux $ git diff --stat
 tools/perf/tests/subcmd-help.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
gentoo linux $ sudo ./tools/perf/perf test -vF disjoint
--- start ---
perf: help.c:107: exclude_cmds: Assertion `cmds->names[ci] == NULL' failed.
Aborted                    (core dumped) tools/perf/perf test -vF disjoint

Then I applied the patch by Sri Jayaramappa with the fix, and the test now works:

gentoo linux $ sudo tools/perf/perf test -vF disjoint
--- start ---
---- end ----
 68.4: Exclude disjoint subcmd names                                 : Ok

So you can add a Reviewed-by: Guilherme Amadio <amadio@gentoo.org>
and/or Tested-by: Guilherme Amadio <amadio@gentoo.org> for both this and
the patch at the link below:

https://lore.kernel.org/lkml/20251202213632.2873731-1-sjayaram@akamai.com/

Cheers,
-Guilherme
