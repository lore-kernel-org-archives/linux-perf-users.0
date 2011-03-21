From: =?utf-8?B?6Zmz6Z+L5Lu7?= <chenwj@iis.sinica.edu.tw>
Subject: What perf_event_paranoid can do?
Date: Mon, 21 Mar 2011 14:14:36 +0800
Message-ID: <20110321061435.GA52815@cs.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from csmailer.cs.nctu.edu.tw ([140.113.235.130]:20280 "EHLO
	csmailer.cs.nctu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482Ab1CUGOl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 21 Mar 2011 02:14:41 -0400
Received: from csmailer.cs.nctu.edu.tw (localhost [127.0.0.1])
	by csmailer.cs.nctu.edu.tw (Postfix) with ESMTP id 9A0FD999
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Mar 2011 14:16:15 +0800 (CST)
Received: from alumni.cs.nctu.edu.tw (alumni.cs.nctu.edu.tw [140.113.235.116])
	by csmailer.cs.nctu.edu.tw (Postfix) with ESMTP id 7803E998
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Mar 2011 14:16:15 +0800 (CST)
Received: (from chenwj@localhost)
	by alumni.cs.nctu.edu.tw (8.14.4/8.14.4/Submit) id p2L6EaSw053295
	for linux-perf-users@vger.kernel.org; Mon, 21 Mar 2011 14:14:36 +0800 (CST)
	(envelope-from chenwj)
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi, folks

  I don't know what "perf_event_paranoid" is for. Sometimes
`perf` told me tweaking perf_event_paranoid. For example,

$ perf stat -e branches:pp ls
No permission to collect stats.
Consider tweaking /proc/sys/kernel/perf_event_paranoid.

  I cannot find any document talks about what perf_event_paranoid
is and what we can do on it.

  Any suggestion appreciated.

Regards,
chenwj

--=20
Wei-Ren Chen (=E9=99=B3=E9=9F=8B=E4=BB=BB)
Parallel Processing Lab, Institute of Information Science,
Academia Sinica, Taiwan (R.O.C.)
Tel:886-2-2788-3799 #1667
