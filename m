From: Harald Servat <harald.servat@bsc.es>
Subject: Re: Information regarding the perf tool
Date: Mon, 04 Nov 2013 18:26:57 +0100
Message-ID: <5277D8E1.9000009@bsc.es>
References: <5266A57F.2000201@bsc.es> <87y55krw6f.fsf@tassilo.jf.intel.com> <52727B0C.5040402@bsc.es> <527287A7.3050908@gmail.com> <5272922E.20007@bsc.es> <52729FE5.3090109@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060301000507000407020100"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mao.bsc.es ([84.88.52.34]:56088 "EHLO opsmail01.bsc.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526Ab3KDR1D (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 4 Nov 2013 12:27:03 -0500
In-Reply-To: <52729FE5.3090109@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: linux-perf-users@vger.kernel.org

This is a multi-part message in MIME format.
--------------060301000507000407020100
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 31/10/13 19:22, David Ahern wrote:
> On 10/31/13, 11:23 AM, Harald Servat wrote:
>> Which is the relation between perf_clock() (or local_clock()) and
>> clock_gettime (CLOCK_MONOTONIC, ). Are they the same? If not, is there a
>> way to correlate them? Or alternatively, is it possible to call
>> local_clock() from the userland?
>
> We still do not have a means of correlating perf_clock to time-of-day,
> monotonic or any other clock source. Still trying.
>
> Pawell Moll has a couple of patches posted -- one uses an ioctl to get
> perf_clock timestamps the other makes perf_clock accessible through
> clock_gettime. See attached.
>
> David

Hello,

   thank you David! Those patches are great! I decided to access perf 
clock through clock_gettime because I'm more used to this call since I 
used it before.

   I understand that the patches are a bit hardcoded, right? I tried to 
#include "/usr/include/linux/time.h" after #include <time.h> but they 
seem to conflict. If I just extract the interesting bits (#define 
CLOCK_PERF) it seems to work. Is there a cleaner way to use this right now?

   JFTR, I have written a very small app that demonstrate the usage of 
this clock_gettime + perf (attached). It is very interesting to see that 
the difference between the monotonic and the perf clock is rather 
similar. However, as time goes by, at least in my machine, perf clock 
seems to advance at a faster pace than the monotonic clock.

Best regards.
-- 



WARNING / LEGAL TEXT: This message is intended only for the use of the
individual or entity to which it is addressed and may contain
information which is privileged, confidential, proprietary, or exempt
from disclosure under applicable law. If you are not the intended
recipient or the person responsible for delivering the message to the
intended recipient, you are strictly prohibited from disclosing,
distributing, copying, or in any way using this message. If you have
received this communication in error, please notify the sender and
destroy and delete any copies you may have received.

http://www.bsc.es/disclaimer
--------------060301000507000407020100
Content-Type: application/x-bzip;
 name="perf-clock.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="perf-clock.tar.bz2"

QlpoOTFBWSZTWVyxSpIAA2f/jN6wAwBff/+fTy/Wjv/v38oACAACAAhQA009oNZsA0JJFTek
mh6TQZHqNGI000Gg0yGhkNB6mm1ABxoyZGEYgGE0GATQaBkyaMmQwgMM1JFGhoNAANBjUMga
AGgAAaGgcaMmRhGIBhNBgE0GgZMmjJkMIDCSQhqY0kynsiTwmKabUDQA0ZGg0GmjEeif2FYs
WxsleEE0bAJp4kIrwAYhYrZld1J6iFqpk2xQ0LAVYTb8L0UOoQJgpxOGBeY3TtX6sVYuJMD1
Eow0EsqYC4cxJel9/kupDNC4eoEbVBmJgmc9ijaHZMc3fgplC8UchTnMtwrFkwD3s0oGiE/D
xSf117t295kY0Tjs5OMMHGUk513t4HsMx56Sk64CniEDSnSqK7cwklRDewoP4hWRtuuhO4+g
5NVHwXGXsL9SeE5p0OfkNr0ReSRm71WcGK6RmGGTMidYUykayAHqMWBvJYEO9jcaZ8NkiXNx
C4EGsHOAOf0fzxERkrZ0tj04UKukCeFRnYdMcrRTzkZKIFEz70Qg5ak04E8Jg5dwKE1DqAHX
iLnjsCUhkwpisc+cUVC7Zv5RktIwwMbzCwvHBjjSE62nyhIrqqRNKqsZvrKK2sqHIgp9AICp
xUk3XshFTga10dKr6g4AsCRKQ9VAblYS5yjDVzrAAABCAAABAILeVnq21iqivVrBKVE0glE0
pSUlJSsymJTEE112FuNWliIShoTcaicqUjuQWKJ6tJWdZsLvg/ERHCwu4YQ06+gvu4NWpcjj
UjScwqkPkYZkdQ6fjxMqDIDmEQ9YuAYRMjsgGig5VY9giBeVxmXZYA4CdXWlgiBi8pah5lDL
pX9Vd5Gcxo+UEB9soaIGrTYBmzV30FJBhYHyCqH+AIILhGNRAHoq3EBNSgLUNChjaBSw+CPG
xlRaktbIvAORBIytYg2DCLEaEZLUSCCAtKkbe/26QMQU4IvFBUgODWA/CqyZjhtcKwvjAwMM
lRkZqCMWWLonKCXdOzbulYPe8eFAwmGMiahEQHXzRU9Coi5nRAgAHktECcohQJUl8KE6jVhI
ppJVUMpiaxpKXar+kgG+MyuiLYkl/xdyRThQkFyxSpI=
--------------060301000507000407020100--
