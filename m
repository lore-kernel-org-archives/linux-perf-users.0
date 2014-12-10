From: Pekka Enberg <penberg@iki.fi>
Subject: Re: Perf support for interpreted and Just-In-Time translated languages
Date: Wed, 10 Dec 2014 09:55:22 +0200
Message-ID: <5487FC6A.3080800@iki.fi>
References: <1417810736.5098.11.camel@oc0276584878.ibm.com> <CAE40pdcXt_gaCXD7n3UED4Y2_gdpH+A3S627TS-72xkbGDoNsA@mail.gmail.com> <20141209203419.GI4189@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56234 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755726AbaLJHzY (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 10 Dec 2014 02:55:24 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 6E69920859
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Dec 2014 02:55:24 -0500 (EST)
In-Reply-To: <20141209203419.GI4189@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Carl Love <cel@us.ibm.com>, Pekka Enberg <penberg@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On 12/9/14 10:34 PM, Arnaldo Carvalho de Melo wrote:
>>>    - How does this work for the offline analysis scenario (i.e., using 'perf archive')?
>>>      Would the /tmp/perf-<pid>.map files have to be copied over to the host system where
>>>      the analysis is being done?
>> Yes. I keep copies of the perf.map along with the perf.data. It might
>> be worth having an option to perf to change the base path for these
>> maps, so that I didn't have to keep putting them in /tmp.
> Right, this was not really designed, was just a proof of concept for
> JATO needs, right Pekka?

Indeed. And like with all useful proof of concepts, people started to 
use it elsewhere as well. :-)

- Pekka
