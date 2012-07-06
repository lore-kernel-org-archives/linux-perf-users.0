From: Arun Sharma <asharma@fb.com>
Subject: Stand alone perf.data parser (Was Re: Callgraph like kcachegrind)
Date: Fri, 6 Jul 2012 07:58:07 -0700
Message-ID: <4FF6FCFF.5070400@fb.com>
References: <r21ub9-8f1.ln1@barney.bruehl.pontohonk.de> <20120705004428.GA17035@infradead.org> <87obntlon0.fsf@sejong.aot.lge.com> <4FF6363A.3020206@fb.com> <CAM9d7cjaRxCgwi2QM5dd3w59mORJ5wo8k9DO71d5AhhL5Fvo=g@mail.gmail.com> <20120706074018.GA7728@somewhere.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:34035 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752801Ab2GFO6S (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 6 Jul 2012 10:58:18 -0400
In-Reply-To: <20120706074018.GA7728@somewhere.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@infradead.org>, Christoph Bartoschek <bartoschek@gmx.de>, linux-perf-users@vger.kernel.org

On 7/6/12 12:40 AM, Frederic Weisbecker wrote:
> Another thing that could be interesting is a perf output mode that dumps
> informations in the Kcachegrind format: http://kcachegrind.sourceforge.net/html/CallgrindFormat.html
> so that Kcachegrind can open it.

I spent a night couple of months ago hacking on this:
https://github.com/adsharma/py-perf-parser

It needs to be combined with code that can symbolize raw IP addresses to 
make it more useful (pydevtools, pyelftools or parts of perf exported as 
a library)

Thought I'd post it here, so folks interested in transforming perf.data 
into something else can hack on it.

  -Arun
