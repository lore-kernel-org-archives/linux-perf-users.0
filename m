From: Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH 2/2] perf: Add a new sort order: SORT_INCLUSIVE
Date: Mon, 12 Mar 2012 12:35:18 -0700
Message-ID: <4F5E4FF6.2010901@fb.com>
References: <1331160079-13821-1-git-send-email-asharma@fb.com> <1331160079-13821-3-git-send-email-asharma@fb.com> <20120308072258.GB20784@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:40237 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755851Ab2CLTfe (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 12 Mar 2012 15:35:34 -0400
In-Reply-To: <20120308072258.GB20784@elte.hu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Namhyung Kim <namhyung.kim@lge.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org

On 3/7/12 11:22 PM, Ingo Molnar wrote:

>
> I.e. this refactoring and splitup of the function into two parts
> is not a detail that should matter to builtin-report.c's
> perf_evsel__add_hist_entry().
>

Agreed. I'll fold this into the next rev.

  -Arun
