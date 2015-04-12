From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: perf user SDT markers
Date: Sat, 11 Apr 2015 19:13:08 -0700
Message-ID: <CAE40pdf1Y3mQMnVi7jSBMg8ovg7x3L17jCf_yGemM_PLLG_k1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:33456 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881AbbDLCNa (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 11 Apr 2015 22:13:30 -0400
Received: by iebmp1 with SMTP id mp1so42900702ieb.0
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Apr 2015 19:13:29 -0700 (PDT)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "linux-perf-use." <linux-perf-users@vger.kernel.org>, hemant@linux.vnet.ibm.com

G'Day,

I was just trying Hemant Kumar's user SDT patch
(http://lwn.net/Articles/618956/); anyone else tried it recently? I
applied it to 4.0.0-rc6, and it creates instrumentation, but doesn't
record the probes.

This works (it finds the Node.js probes):

# ./perf sdt-cache --dump
/home/bgregg-testtest/node-standard/out/Release/node:
   %node:net__server__connection
   %node:net__stream__end
   %node:net__socket__read
   %node:net__socket__write
   %node:http__server__request
   %node:http__server__response
   %node:http__client__request
   %node:http__client__response
   %node:gc__done
   %node:gc__start

But I can't "perf list" or record them:

# ./perf record -e '%node:http__server__request' -aR
invalid or unsupported event: '%node:http__server__request'
Run 'perf list' for a list of valid events
[...]

stap works:

# /root/systemtap-2.8/bin/stap -e 'probe
process("/home/bgregg-testtest/node-standard/out/Release/node").mark("http__server__request")
{ println("hit"); }'
hit
hit

Brendan
