From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Understanding perf mem -t load results
Date: Wed, 08 Jan 2014 11:44:25 -0800
Message-ID: <87ppo245t2.fsf@tassilo.jf.intel.com>
References: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr>
	<877gb5vmmn.fsf@tassilo.jf.intel.com> <52AE2721.8020501@insa-lyon.fr>
	<20131215234548.GP21717@two.firstfloor.org>
	<CALbiyZzWsDCANnhMsd9bsdqyjYtFNeSNUiUgvs7hSwH-w4ZZWw@mail.gmail.com>
	<CALbiyZy++Wgcoo6J7sbHHN1sWWJJKe36q4Gvtdnb0vOLjQ=nTg@mail.gmail.com>
	<20131224021822.GH20765@two.firstfloor.org>
	<52B93352.2030909@gmail.com>
	<20131224072813.GI20765@two.firstfloor.org>
	<52B93B01.4020305@gmail.com>
	<20131224212728.GK20765@two.firstfloor.org>
	<52BAB2A8.1040709@gmail.com>
	<CALbiyZyUncZZq7mU=+Hk9mYY7q3ugWiiESWSS9RSP-PfwB9u=w@mail.gmail.com>
	<87wqib4h5m.fsf@tassilo.jf.intel.com>
	<CALbiyZyaxvbx77oVFKWbbnCx69A6GkA5=n50G7M8=+iZTyPq8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33479 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750861AbaAHToq (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 8 Jan 2014 14:44:46 -0500
In-Reply-To: <CALbiyZyaxvbx77oVFKWbbnCx69A6GkA5=n50G7M8=+iZTyPq8g@mail.gmail.com>
	(Manuel Selva's message of "Wed, 8 Jan 2014 09:53:18 +0100")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Manuel Selva <selva.manuel@gmail.com> writes:

> In previous answer, you told me that the
> PERF_SAMPLE_IP field is filled with "the IP of a random core on the
> socket that happens to read the uncore registers",


This was for uncore sampling, not perf mem.

perf mem reports the core IP.


-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
