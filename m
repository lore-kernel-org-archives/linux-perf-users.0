Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E810F1292CF;
	Thu,  9 May 2024 21:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715291973; cv=none; b=LaY44bBGBHP63n3XLuTEiz/CO+3UnUolzxW62CGSdccFx7o+ZLfCOuT59Uyp46heH+/9Tn2E70FWlIBDMHzN2mUNuTgxBYNC1FaHP9VVbVhI9bzvCMYl/GjpqOr7wp1b3oRTzQaVJr8GpCgYL8oHtwbBBSzpvAGIgj+XniZ+LZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715291973; c=relaxed/simple;
	bh=vQTSqcXkDJPaIBbcnpAEzAyTOeOOsBcfw+OQRd5OE80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tATYds8wxdUXg7cYJZBhIXZlJprS1kXVJtU85JTa4frr2gb2fjwtT4e6LHcsucRSMexe+2naTAuIe+p1SPtpjIoV+PchgQjJD324x/7A+OqFy41rIf8P6xgrAGk8rzY3ALoQDGPCnE+4SXTcqPnT9dH3evCzG+wM//pCQSNrYMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=Djm6UYGC; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="Djm6UYGC"
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 0229B14C2DB;
	Thu,  9 May 2024 23:59:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1715291968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iPoojjKgcH+TQ6GRd67EtYx4kNvRFbwZWP5w+OBCKw=;
	b=Djm6UYGCuu4rndXevZy7UP2V8BnEec3M++zEJPI9+UUWspmBHME3aJJgPzG0EtX/Qbakl+
	fUD3h3feYQuTeH3vT5gZNg57//xeLlImnRxZhccjywu8anD1O4dP7HZf1JfLL9cp9SFhpP
	A+HA0ljILkymtIQsNriFR/NVrFPpIXk2nKHNe8mTO4xGwl58xuIFbe0xnwnEWQLkOvJqb2
	nL/8ROkwZtDeimF4aNo18n90M3ytNfXk3RxjCosx90mdkIpqyqqq2FAMWdj5/wcOoZTued
	JA9gvEOBDA4a2I4SAOBgHNVOeA981BsnbJ+4YnF4tzHbSZp0S5UqUmng7r+mrg==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id d6740ee3;
	Thu, 9 May 2024 21:59:20 +0000 (UTC)
Date: Fri, 10 May 2024 06:59:05 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf parse-events: pass parse_state to
 add_tracepoint
Message-ID: <Zj1HKQVuQDQtk5cK@codewreck.org>
References: <20240505-perf_digit-v2-0-6ece307fdaad@codewreck.org>
 <20240505-perf_digit-v2-1-6ece307fdaad@codewreck.org>
 <CAP-5=fUmeyd3BR7njJEDQ-=qkpvLPMoQO-7De+3mqLaSOoZZxw@mail.gmail.com>
 <Zj0--YbYSm-s9vRh@x1>
 <Zj1EK8cO-Vxc-YuJ@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zj1EK8cO-Vxc-YuJ@x1>

Arnaldo Carvalho de Melo wrote on Thu, May 09, 2024 at 06:46:19PM -0300:
> ⬢[acme@toolbox perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
> [...]
> tests/parse-events.c:2274:26: error: ‘test__checkevent_tracepoint’ undeclared here (not in a function); did you mean ‘test__checkevent_breakpoint’?
>  2274 |                 .check = test__checkevent_tracepoint,
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                          test__checkevent_breakpoint
> make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: tests/parse-events.o] Error 1
> make[6]: *** Waiting for unfinished jobs....

Sorry, didn't know about build-test; I've confirmed the problem [and
will eventually want to check how to build this cleanly on nixos, it's a
pain to shuffle the patch around to rebuild perf...]


It looks like the test case just needs an extra ifdef for
LIBTRACEEVEENT?

----
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 417d4782a520..edc2adcf1bae 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -2269,11 +2269,13 @@ static const struct evlist_test test__events[] = {
 		.check = test__checkevent_breakpoint_2_events,
 		/* 3 */
 	},
+#ifdef HAVE_LIBTRACEEVENT
 	{
 		.name = "9p:9p_client_req",
 		.check = test__checkevent_tracepoint,
 		/* 4 */
 	},
+#endif
 };
 
 static const struct evlist_test test__events_pmu[] = {
----

I'll send a v4 with that rolled in after confirming the full build-test
passes.

-- 
Dominique Martinet | Asmadeus
