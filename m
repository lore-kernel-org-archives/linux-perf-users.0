From: =?utf-8?B?6Zmz6Z+L5Lu7?= <chenwj@iis.sinica.edu.tw>
Subject: Permission denied while profiling my own application
Date: Tue, 15 Mar 2011 16:28:05 +0800
Message-ID: <20110315082804.GA91258@cs.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from csmailer.cs.nctu.edu.tw ([140.113.235.130]:53812 "EHLO
	csmailer.cs.nctu.edu.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754457Ab1COI2G convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 15 Mar 2011 04:28:06 -0400
Received: from csmailer.cs.nctu.edu.tw (localhost [127.0.0.1])
	by csmailer.cs.nctu.edu.tw (Postfix) with ESMTP id 3DAF82A1
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Mar 2011 16:29:49 +0800 (CST)
Received: from alumni.cs.nctu.edu.tw (alumni.cs.nctu.edu.tw [140.113.235.116])
	by csmailer.cs.nctu.edu.tw (Postfix) with ESMTP id 1D6852A0
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Mar 2011 16:29:49 +0800 (CST)
Received: (from chenwj@localhost)
	by alumni.cs.nctu.edu.tw (8.14.4/8.14.4/Submit) id p2F8S5Dk091345
	for linux-perf-users@vger.kernel.org; Tue, 15 Mar 2011 16:28:05 +0800 (CST)
	(envelope-from chenwj)
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi, all

  `perf` works fine while profiling system utilities (ls, git, ... etc)=
=2E
But I got a permission deny when I tried to profile a HelloWorld
program which was compiled by myself. For example,

$ perf stat -e cycles hello
hello: Permission denied
Terminated

  Do I miss something? Thanks.

Regards,
chenwj

--=20
Wei-Ren Chen (=E9=99=B3=E9=9F=8B=E4=BB=BB)
Parallel Processing Lab, Institute of Information Science,
Academia Sinica, Taiwan (R.O.C.)
Tel:886-2-2788-3799 #1667
