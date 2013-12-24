From: Manuel Selva <selva.manuel@gmail.com>
Subject: Re: Understanding perf mem -t load results
Date: Tue, 24 Dec 2013 08:42:57 +0100
Message-ID: <52B93B01.4020305@gmail.com>
References: <1776760155.10395562.1386857164818.JavaMail.root@insa-lyon.fr> <877gb5vmmn.fsf@tassilo.jf.intel.com> <52AE2721.8020501@insa-lyon.fr> <20131215234548.GP21717@two.firstfloor.org> <CALbiyZzWsDCANnhMsd9bsdqyjYtFNeSNUiUgvs7hSwH-w4ZZWw@mail.gmail.com> <CALbiyZy++Wgcoo6J7sbHHN1sWWJJKe36q4Gvtdnb0vOLjQ=nTg@mail.gmail.com> <20131224021822.GH20765@two.firstfloor.org> <52B93352.2030909@gmail.com> <20131224072813.GI20765@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34373 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab3LXHnC (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 24 Dec 2013 02:43:02 -0500
Received: by mail-wi0-f172.google.com with SMTP id en1so11723527wid.17
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Dec 2013 23:42:58 -0800 (PST)
In-Reply-To: <20131224072813.GI20765@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-perf-users@vger.kernel.org

On 12/24/2013 08:28 AM, Andi Kleen wrote:
> On Tue, Dec 24, 2013 at 08:10:10AM +0100, Manuel Selva wrote:
>> "You cannot use uncore events to sample IPs" means that the values
>> corresponding to PERF_SAMPLE_IP are not correct ? Some benchmarks I
>> did by sampling ME_INST_RETIRED with PERF_SAMPLE_IP let me think
>> that I was able to get the source of th event. The IP value was
>> coherent. Maybe this is not always the case.
>
> It's the IP of a random core on the socket that happens to read the u=
ncore
> registers.
>

Ok. Where should I have read this information, in the Intel Software=20
Developer=92s Manual volume 3B (I guess this is a hardware limitation) =
?

I checked what can be measured with the offcore facility. I can ask to=20
count remote memory accesses, but now I am not sure PEBS is enable for=20
these events. If the answer is no, I can't accurately identify remote=20
memory accesses with offcore events ? As a consequence I am wondering i=
f=20
there is a way to do such thing ?

Manu
