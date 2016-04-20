From: Daniel Gutson <daniel.gutson@tallertechnologies.com>
Subject: Re: Ability for classifying of measurements
Date: Wed, 20 Apr 2016 13:08:25 -0300
Message-ID: <CAF5HaEW29wA6ZtNkGhTdFQGwoZp=QWaxEgt3n_7Ph+iA2YVyxQ@mail.gmail.com>
References: <1461099117-21401-1-git-send-email-leonardo.boquillon@tallertechnologies.com>
	<87ega0whpq.fsf@tassilo.jf.intel.com>
	<CAF5HaEXOwn0_b=an2RR2FT++ktRXLpAP2WHPE7O=kdVKVRYKVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:34934 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbcDTQI0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 20 Apr 2016 12:08:26 -0400
Received: by mail-ob0-f177.google.com with SMTP id n10so30442084obb.2
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Apr 2016 09:08:25 -0700 (PDT)
In-Reply-To: <CAF5HaEXOwn0_b=an2RR2FT++ktRXLpAP2WHPE7O=kdVKVRYKVQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Leonardo Boquillon <leonardo.boquillon@tallertechnologies.com>, linux-perf-users@vger.kernel.org

(2nd resend due to Majordomo rejection, this time as plain text..sorry
for inconveniences)


On Wed, Apr 20, 2016 at 10:26 AM, Daniel Gutson
<daniel.gutson@tallertechnologies.com> wrote:
>
> El 20/4/2016 10:08, "Andi Kleen" <andi@firstfloor.org> escribi=C3=B3:
>
 Hi Andi.
>
>>
>> Leonardo Boquillon <leonardo.boquillon@tallertechnologies.com> write=
s:
>> >
>> > In no way we intend this patch to be committed; we just want to sh=
ow the
>> > idea
>> > and start a discussion instead, focusing on the idea first rather =
than
>> > on the
>> > design & code.
>>
>> That's good because the patch as written is a big security hole (and=
 in
>> fact will not work on any systems with SMAP enabled)
>>
>> The basic concept seems reasonable, although a single address may be
>> too inflexible.
>
 Agree, this was the first step. What we would like to see implemented =
from
 this feature is, 1) some dwarf-aided ability to specify watched variab=
les in
 the perf record command (e.g. perf record --groupby=3D"::var1,
class1::staticvar2" ),
and 2) provide an API to the applications so they can
 communicate with perf_events telling what's going on, such as the exam=
ple we
 are showing here (which is *just* an example to fuel this discussion).=
 This
 API would lead to intrusively mess the code of the app but not more th=
an
 people already do with debugging printfs; this would be very important=
 for
 performance-centric applications.

 So, is there some consensus to start defining the API?
>
>>
>> Often the main request I hear is for a simple way for an application
>> to turn on/off profiling, and perhaps add markers to distinguish
>> phases. It many cases that may be good enough.
>>
>> -Andi
>>
>> --
>> ak@linux.intel.com -- Speaking for myself only



--=20

Daniel F. Gutson
Engineering Manager

San Lorenzo 47, 3rd Floor, Office 5
C=C3=B3rdoba, Argentina

Phone:   +54 351 4217888 / +54 351 4218211
Skype:    dgutson
LinkedIn: http://ar.linkedin.com/in/danielgutson
