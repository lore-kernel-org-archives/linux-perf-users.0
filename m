From: Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH 0/2] perf: add sort by inclusive time functionality (v2)
Date: Tue, 13 Mar 2012 11:45:19 -0700
Message-ID: <4F5F95BF.8060104@fb.com>
References: <1331160079-13821-1-git-send-email-asharma@fb.com> <4F5DA91F.7060908@lge.com> <4F5E3E8C.1020005@fb.com> <4F5E9FFA.7060300@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59118 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753222Ab2CMSqF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 13 Mar 2012 14:46:05 -0400
In-Reply-To: <4F5E9FFA.7060300@lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung.kim@lge.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org

On 3/12/12 6:16 PM, Namhyung Kim wrote:

> $ perf record -g sleep 1
> $ perf report -s inclusive,symbol

Thanks. I was able to reproduce the hangs and they went away after I 
added sort_sym_inclusive (a copy of sort_sym, except for the se_header).

The output of perf report now better describes how the symbols are 
sorted. The text reads: "Symbol (Inclusive)".

v3 is coming via my next mail.

  -Arun
