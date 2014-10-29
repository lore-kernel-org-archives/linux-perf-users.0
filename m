From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Load latency sampling on Sandy Bridge
Date: Wed, 29 Oct 2014 16:02:30 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1410291601080.895@vincent-weaver-1.umelst.maine.edu>
References: <5450A049.3040803@insa-lyon.fr> <alpine.DEB.2.11.1410291207160.21291@vincent-weaver-1.umelst.maine.edu> <90E64847-211C-4331-82D1-763FC17C03CE@insa-lyon.fr> <alpine.DEB.2.11.1410291452280.895@vincent-weaver-1.umelst.maine.edu> <545136EF.9030503@insa-lyon.fr>
 <alpine.DEB.2.11.1410291509160.895@vincent-weaver-1.umelst.maine.edu> <54513E55.9060503@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33353 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756185AbaJ2Tzd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Oct 2014 15:55:33 -0400
Received: by mail-qg0-f44.google.com with SMTP id q107so2853730qgd.17
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2014 12:55:32 -0700 (PDT)
In-Reply-To: <54513E55.9060503@insa-lyon.fr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <manuel.selva@insa-lyon.fr>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Wed, 29 Oct 2014, Manuel Selva wrote:

> perf_event_intel: PEBS disabled due to CPU errata, please upgrade microcode
> 
> Does it mean that I must "upgrade my hardware" through the upgrade of
> microcode ? I never did such a thing.

Usually the microcode is updated at boot time.  Usually your distribution 
will have some sort of microcode update package you can install that will 
do this for you automatically.

Vince
