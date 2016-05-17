From: Vasmi Abidi <vabidi@gmail.com>
Subject: how to get "--children" overhead with perf?
Date: Tue, 17 May 2016 17:38:48 +0000 (UTC)
Message-ID: <loom.20160517T193444-154@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35148 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751072AbcEQRkG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 17 May 2016 13:40:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1b2iyS-0001g8-7Q
	for linux-perf-users@vger.kernel.org; Tue, 17 May 2016 19:40:04 +0200
Received: from smtp.rabbitmq.com ([192.240.153.112])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2016 19:40:04 +0200
Received: from vabidi by smtp.rabbitmq.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2016 19:40:04 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

   Which version of perf gives the overhead of the children in the caller view?
    On my ubuntu14.04.1 machine, I don't see any options for this.

 root@prmh:~# perf --version
perf version 3.13.11.4
root@:~# perf report --children
  Error: unknown option `children'

   thanks,
   Vasmi
