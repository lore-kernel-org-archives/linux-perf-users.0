From: Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH] perf: Add a new sort order: SORT_INCLUSIVE (v6)
Date: Fri, 30 Mar 2012 22:43:18 -0700
Message-ID: <4F769976.3070203@fb.com>
References: <1333172421-6775-2-git-send-email-asharma@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:33585 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751997Ab2CaFnr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 31 Mar 2012 01:43:47 -0400
In-Reply-To: <1333172421-6775-2-git-send-email-asharma@fb.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <asharma@fb.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Namhyung Kim <namhyung.kim@lge.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org

[ Meant to include v6 ChangeLog as well. Technical difficulties.. ]

v6 ChangeLog:

rebased to tip:perf/core and fixed a minor problem in computing
the total period in hists__remove_entry_filter(). Needed to
use period_self instead of period.
