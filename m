From: =?utf-8?B?6Zmz6Z+L5Lu7?= <chenwj@iis.sinica.edu.tw>
Subject: perf counts nothing on SPARC
Date: Tue, 15 Mar 2011 16:39:54 +0800
Message-ID: <20110315083954.GA91348@cs.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from csmailer.cs.nctu.edu.tw ([140.113.235.130]:27947 "EHLO
	csmailer.cs.nctu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980Ab1COIjz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 15 Mar 2011 04:39:55 -0400
Received: from csmailer.cs.nctu.edu.tw (localhost [127.0.0.1])
	by csmailer.cs.nctu.edu.tw (Postfix) with ESMTP id 957E82BA
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Mar 2011 16:41:38 +0800 (CST)
Received: from alumni.cs.nctu.edu.tw (alumni.cs.nctu.edu.tw [140.113.235.116])
	by csmailer.cs.nctu.edu.tw (Postfix) with ESMTP id 766522B9
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Mar 2011 16:41:38 +0800 (CST)
Received: (from chenwj@localhost)
	by alumni.cs.nctu.edu.tw (8.14.4/8.14.4/Submit) id p2F8dsXw091675
	for linux-perf-users@vger.kernel.org; Tue, 15 Mar 2011 16:39:54 +0800 (CST)
	(envelope-from chenwj)
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi, all

  I don't know this is normal or not. But I got nothing when I
ran `perf` on a SPARC machine. For example,

$ perf stat -e instructions git gc
Nothing new to pack.

 Performance counter stats for 'git gc':

                 0 instructions             #      0.000 IPC

        0.188904740  seconds time elapsed

  I think there should be more than 1 instruction at least. But
as you can see from the example, I got zero instruction while
running `git gc`.

  Any idea?

Regards,
chenwj

--=20
Wei-Ren Chen (=E9=99=B3=E9=9F=8B=E4=BB=BB)
Parallel Processing Lab, Institute of Information Science,
Academia Sinica, Taiwan (R.O.C.)
Tel:886-2-2788-3799 #1667
