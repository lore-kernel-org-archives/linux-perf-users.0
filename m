From: Ulf Hermann <ulf.hermann@theqtcompany.com>
Subject: Re: pipe_output format different from file output?
Date: Tue, 20 Jan 2015 16:13:16 +0100
Message-ID: <54BE708C.6000006@theqtcompany.com>
References: <CAGszK3ji6h_GkzqSJ59Eyw+4ALj+pwxcRb41Y65ZC-eKjiz3bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-db3on0119.outbound.protection.outlook.com ([157.55.234.119]:42304
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752130AbbATP1l (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 20 Jan 2015 10:27:41 -0500
In-Reply-To: <CAGszK3ji6h_GkzqSJ59Eyw+4ALj+pwxcRb41Y65ZC-eKjiz3bg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jan Heylen <heyleke@gmail.com>, linux-perf-users@vger.kernel.org

> # perf record sleep 1
> # perf report -i perf.data
> --> expected output
> (note: -i perf.data not really needed)
>
> # perf record -o - sleep 1 | cat > perf.data
> # perf report -i perf.data
> --> incompatible file format (rerun with -v to learn more)
> # perf report -i - < perf.data
> --> expected output
> [...]
> But I still want to understand why there is a difference (and what is
> the consequence of using the pipe_output format)

As I've been fighting with the perf data format for a while now, I can answer this:

With the "normal" output various meta information is written to the end of the file. If you pipe the output to a different process that is impractical because the other process would have to buffer its input until perf stops, making it impossible to analyze the events as they arrive. That's why they came up with a second format which puts the meta information inline with the actual data. Apparently perf will only read that from stdin, though.

best regards,
Ulf Hermann
