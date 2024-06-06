Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F271E495;
	Thu,  6 Jun 2024 17:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693976; cv=none; b=CSeGYZmn8zD7mS0vex3u7BTAgxZ6MqHVj9XE9zOa38QAFa0mg/Z0Py1uaAOSPclBRXwqRF2YVNwI7VWpHif60OdnxmL54g/Di7yzyj/glI6dSRiu4DZB6WaWNCAj0+0n6cnwUbO/mhss6rpKKrnz55bfxAmcXIY9n0DwKF8r0+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693976; c=relaxed/simple;
	bh=yNzSGMzBPpeJxQaqXhbDJgrlYAct+LNjRn53sZZoCBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJ3wdhj7wmUWOM3ur81hwhTF4qfF+qLuJirZ8DYxqaaIMwugmeYaG7/pRqWZ+b9DxklPhHJ7TO2YxPwTfQiKsICr6mKXHbe8gPmRam0bIV17d4/OTxXx7tuSrm7OGlUQwMh0Xw5zDxkS0P2A+X+V5cpp89Q2DcjHoBlKu/SvZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NW99UE9o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NW99UE9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43CA3C2BD10;
	Thu,  6 Jun 2024 17:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717693975;
	bh=yNzSGMzBPpeJxQaqXhbDJgrlYAct+LNjRn53sZZoCBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NW99UE9ol72yWu8MgmnC9Dt3kKTxzcj+FrIvKXR4YzpclPRCy/uHN2SVJXrIzkYev
	 qBtSG4wO1IUhq/QkvjFSXanhWQ14Vm3kKDwubQxW1f3sWGmouPl/dasGn1k76DkgKR
	 C5KN8DAfDX9aqEoy3eAtfDTN/SWewyp/fKJyl3fb6v3LwdKOerDrm5BWwnBbQewKlP
	 Ye2BtsBrlShxUR7CpASU3eZMR3cjQZflGtPWXo6k4iHRlIjRHWgcigMVrFhRZlYi3v
	 7/mEuH0ZCTamuIHNJgr7UD9qXWjqSJgPHQ3LN37+wmTMgADzBgJkrTEZG4oKcFPyfx
	 HmOwQsry8p/ow==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	James Clark <james.clark@arm.com>,
	=?UTF-8?q?Cl=C3=A9ment=20Le=20Goffic?= <clement.legoffic@foss.st.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] perf: parse-events: Fix compilation error while defining DEBUG_PARSER
Date: Thu,  6 Jun 2024 10:12:52 -0700
Message-ID: <171769393997.2340193.15187370089504659355.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240605140453.614862-1-clement.legoffic@foss.st.com>
References: <20240605140453.614862-1-clement.legoffic@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 05 Jun 2024 16:04:53 +0200, Clément Le Goffic wrote:

> Compiling perf tool with 'DEBUG_PARSER=1' leads to errors:
> 
> $> make -C tools/perf PARSER_DEBUG=1 NO_LIBTRACEEVENT=1
> ...
>   CC      util/expr-flex.o
>   CC      util/expr.o
> util/parse-events.c:33:12: error: redundant redeclaration of ‘parse_events_debug’ [-Werror=redundant-decls]
>    33 | extern int parse_events_debug;
>       |            ^~~~~~~~~~~~~~~~~~
> In file included from util/parse-events.c:18:
> util/parse-events-bison.h:43:12: note: previous declaration of ‘parse_events_debug’ with type ‘int’
>    43 | extern int parse_events_debug;
>       |            ^~~~~~~~~~~~~~~~~~
> util/expr.c:27:12: error: redundant redeclaration of ‘expr_debug’ [-Werror=redundant-decls]
>    27 | extern int expr_debug;
>       |            ^~~~~~~~~~
> In file included from util/expr.c:11:
> util/expr-bison.h:43:12: note: previous declaration of ‘expr_debug’ with type ‘int’
>    43 | extern int expr_debug;
>       |            ^~~~~~~~~~
> cc-1: all warnings being treated as errors
> 
> [...]

Applied to perf-tools-next, thanks!


Best regards,
Namhyung
