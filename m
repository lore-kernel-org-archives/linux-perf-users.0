From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Understanding perf mem -t load results
Date: Tue, 24 Dec 2013 08:28:13 +0100
Message-ID: <20131224072813.GI20765@two.firstfloor.org>
References: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr>
 <877gb5vmmn.fsf@tassilo.jf.intel.com>
 <52AE2721.8020501@insa-lyon.fr>
 <20131215234548.GP21717@two.firstfloor.org>
 <CALbiyZzWsDCANnhMsd9bsdqyjYtFNeSNUiUgvs7hSwH-w4ZZWw@mail.gmail.com>
 <CALbiyZy++Wgcoo6J7sbHHN1sWWJJKe36q4Gvtdnb0vOLjQ=nTg@mail.gmail.com>
 <20131224021822.GH20765@two.firstfloor.org>
 <52B93352.2030909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from one.firstfloor.org ([193.170.194.197]:54283 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab3LXH2P (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 Dec 2013 02:28:15 -0500
Content-Disposition: inline
In-Reply-To: <52B93352.2030909@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Manuel Selva <selva.manuel@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

On Tue, Dec 24, 2013 at 08:10:10AM +0100, Manuel Selva wrote:
> "You cannot use uncore events to sample IPs" means that the values
> corresponding to PERF_SAMPLE_IP are not correct ? Some benchmarks I
> did by sampling ME_INST_RETIRED with PERF_SAMPLE_IP let me think
> that I was able to get the source of th event. The IP value was
> coherent. Maybe this is not always the case.

It's the IP of a random core on the socket that happens to read the uncore
registers.

-Andi
