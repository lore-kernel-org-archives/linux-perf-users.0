From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: Information regarding the perf tool
Date: Mon, 04 Nov 2013 18:02:43 +0000
Message-ID: <1383588163.3234.34.camel@hornet>
References: <5266A57F.2000201@bsc.es> <87y55krw6f.fsf@tassilo.jf.intel.com>
	 <52727B0C.5040402@bsc.es> <527287A7.3050908@gmail.com>
	 <5272922E.20007@bsc.es> <52729FE5.3090109@gmail.com>
	 <5277D8E1.9000009@bsc.es> <5277DF11.7080601@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:56528 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754496Ab3KDSCq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 4 Nov 2013 13:02:46 -0500
In-Reply-To: <5277DF11.7080601@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Harald Servat <harald.servat@bsc.es>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Mon, 2013-11-04 at 17:53 +0000, David Ahern wrote:
> that's why we would like to get a perf_clock/trace_clock time source=20
> exported by the kernel.

By all means. One of the issues right now is that perf and trace clocks
can be (and are at least on ARM) different. Once the LLTng people get
around providing One Source To Rule Them All, we'll be in much better
position to convince John Stultz to provide a posix clock for it (which
should make it VDSO-able as well).

Pawe=C5=82
