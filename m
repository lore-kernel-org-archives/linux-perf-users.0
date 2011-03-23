From: Arun Sharma <arun@sharma-home.net>
Subject: Re: from perf_trace_context import fails?
Date: Wed, 23 Mar 2011 12:29:26 -0700
Message-ID: <AANLkTim9yL1UdGAR5CvhtxTPHXeJCRnGmV+g=4gejg2M@mail.gmail.com>
References: <AANLkTikzNfTyHHgL5QiqSwXJvd-rGqCOx1MkizkqPuOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47945 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756546Ab1CWT31 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 Mar 2011 15:29:27 -0400
Received: by iwn34 with SMTP id 34so8879689iwn.19
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Mar 2011 12:29:26 -0700 (PDT)
In-Reply-To: <AANLkTikzNfTyHHgL5QiqSwXJvd-rGqCOx1MkizkqPuOw@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

On Tue, Mar 22, 2011 at 6:04 PM, Arun Sharma <arun@sharma-home.net> wro=
te:

> # python perf-script.py
> Traceback (most recent call last):
> =C2=A0File "perf-script.py", line 16, in <module>
> =C2=A0 =C2=A0from perf_trace_context import *
> ImportError: No module named perf_trace_context

My bad. I forgot to run this as:

perf script -s perf-script.py

-Arun
