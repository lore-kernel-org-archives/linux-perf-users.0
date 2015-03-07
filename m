From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: event power/energy-dram/
Date: Sat, 7 Mar 2015 00:50:36 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1503070049130.27106@vincent-weaver-1.umelst.maine.edu>
References: <CAJ38vxvP3wJ8tBKoithLa6T7CztVrjiWuRYVDO8s1s5vMD8++w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-220717116-1425707443=:27106"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:36819 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbCGFqy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 7 Mar 2015 00:46:54 -0500
Received: by qgdz107 with SMTP id z107so17696989qgd.3
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Mar 2015 21:46:53 -0800 (PST)
In-Reply-To: <CAJ38vxvP3wJ8tBKoithLa6T7CztVrjiWuRYVDO8s1s5vMD8++w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?ISO-8859-15?Q?Jos=E9_Sim=E3o?= <jose.m.simao@gmail.com>
Cc: linux-perf-users@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-220717116-1425707443=:27106
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 6 Mar 2015, José Simão wrote:

> The documentation on this counters says "servers only"
> (http://lwn.net/Articles/573602/).
> 
> Can anyone tell me how if I can read this counter on my system and how?

the documentation is correct, normal sandybridge chips (non-EP) do not 
support dram measuring, and even some of the EP models do not support it 
if the motherboard or BIOS does not properly support it.

Vince
--8323328-220717116-1425707443=:27106--
