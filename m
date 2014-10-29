From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Load latency sampling on Sandy Bridge
Date: Wed, 29 Oct 2014 14:53:45 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1410291452280.895@vincent-weaver-1.umelst.maine.edu>
References: <5450A049.3040803@insa-lyon.fr> <alpine.DEB.2.11.1410291207160.21291@vincent-weaver-1.umelst.maine.edu> <90E64847-211C-4331-82D1-763FC17C03CE@insa-lyon.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:52980 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbaJ2Sqv (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 29 Oct 2014 14:46:51 -0400
Received: by mail-qc0-f172.google.com with SMTP id i17so2983791qcy.3
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2014 11:46:50 -0700 (PDT)
In-Reply-To: <90E64847-211C-4331-82D1-763FC17C03CE@insa-lyon.fr>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <manuel.selva@insa-lyon.fr>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Wed, 29 Oct 2014, Manuel Selva wrote:

> The same event as the one you mentionned (I also checked that it's the 
> same event than the one used by perf mem record)

so perf mem record doesn't work for you either?

I checked on my sandybridge-ep machine running Linux 3.14 and latency 
measurement seems to be working fine there too.

Vince
