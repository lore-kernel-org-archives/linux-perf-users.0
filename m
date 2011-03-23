From: =?utf-8?B?6Zmz6Z+L5Lu7?= <chenwj@iis.sinica.edu.tw>
Subject: Re: perf script and raw events?
Date: Wed, 23 Mar 2011 09:25:52 +0800
Message-ID: <20110323012552.GA2080@cs.nctu.edu.tw>
References: <20110322224116.GA3794@dev1756.snc6.facebook.com>
 <4D892E0E.3010505@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from csmailer.cs.nctu.edu.tw ([140.113.235.130]:43833 "EHLO
	csmailer.cs.nctu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660Ab1CWBZz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 22 Mar 2011 21:25:55 -0400
Content-Disposition: inline
In-Reply-To: <4D892E0E.3010505@cisco.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <daahern@cisco.com>
Cc: Arun Sharma <asharma@fb.com>, linux-perf-users@vger.kernel.org

Hi,

> What is that raw event? Where do you find the encodings for raw event=
s?

  You can try libpfm4.

$ git clone git://perfmon2.git.sourceforge.net/gitroot/perfmon2/libpfm4

  `showevtinfo` in libpfm4/examples/ lists all events supported by the
CPU, including raw events.

  `evt2raw` in libpfm4/perf_examples converts event names into raw even=
t
recognized by perf.

Regards,
chenwj

--=20
Wei-Ren Chen (=E9=99=B3=E9=9F=8B=E4=BB=BB)
Parallel Processing Lab, Institute of Information Science,
Academia Sinica, Taiwan (R.O.C.)
Tel:886-2-2788-3799 #1667
