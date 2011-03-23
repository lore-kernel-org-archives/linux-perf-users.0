From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] Symbolize stripped binaries without buildid
Date: Wed, 23 Mar 2011 11:23:06 +0530
Message-ID: <20110323055306.GA4259@linux.vnet.ibm.com>
References: <20110128221133.GA25958@radium.snc4.facebook.com>
 <20110322212247.GA3594@ghostprotocols.net>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from e9.ny.us.ibm.com ([32.97.182.139]:55164 "EHLO e9.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750720Ab1CWGAr (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 23 Mar 2011 02:00:47 -0400
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p2N5XmrO031840
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Mar 2011 01:33:48 -0400
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id CDBFA6E8036
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Mar 2011 02:00:46 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id p2N60kM4191258
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Mar 2011 02:00:46 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id p2N60gdF005241
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Mar 2011 03:00:46 -0300
Content-Disposition: inline
In-Reply-To: <20110322212247.GA3594@ghostprotocols.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Arun Sharma <asharma@fb.com>, Dave Martin <dave.martin@linaro.org>, linux-perf-users@vger.kernel.org, Suzuki Poulose <suzuki@in.ibm.com>


> 
>     perf symbols: Look at .dymsym again if .symtab not found
>     
>     The original intent of the code was to repeat the search with
>     want_symtab = 0. But as the code stands now, we never hit the "default"
>     case of the switch statement. Which means we never repeat the search.

Tested and it works now.

-- 
Thanks and Regards
Srikar
