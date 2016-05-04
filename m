From: Daniel Gutson <daniel.gutson@tallertechnologies.com>
Subject: Re: Ability for classifying of measurements\
Date: Wed, 4 May 2016 14:26:17 -0300
Message-ID: <CAF5HaEVVrw6w3KKCRAk0Fis_TAP0vzfrZP6VPgMiwLJPYkn_xg@mail.gmail.com>
References: <1461099117-21401-1-git-send-email-leonardo.boquillon@tallertechnologies.com>
	<87ega0whpq.fsf@tassilo.jf.intel.com>
	<CAF5HaEXOwn0_b=an2RR2FT++ktRXLpAP2WHPE7O=kdVKVRYKVQ@mail.gmail.com>
	<CAF5HaEW29wA6ZtNkGhTdFQGwoZp=QWaxEgt3n_7Ph+iA2YVyxQ@mail.gmail.com>
	<20160420174724.GP9407@two.firstfloor.org>
	<CAF5HaEXP1vvDod5eRnY2DYvTzeZDC_w15SbNpPEdosbv52qbAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:33268 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754621AbcEDR0S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 4 May 2016 13:26:18 -0400
Received: by mail-ob0-f173.google.com with SMTP id x1so24161672obt.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 May 2016 10:26:17 -0700 (PDT)
In-Reply-To: <CAF5HaEXP1vvDod5eRnY2DYvTzeZDC_w15SbNpPEdosbv52qbAQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Leonardo Boquillon <leonardo.boquillon@tallertechnologies.com>, linux-perf-users@vger.kernel.org

On Wed, May 4, 2016 at 2:20 PM, Daniel Gutson
<daniel.gutson@tallertechnologies.com> wrote:
> On Wed, Apr 20, 2016 at 2:47 PM, Andi Kleen <andi@firstfloor.org> wro=
te:
>>>  Agree, this was the first step. What we would like to see implemen=
ted from
>>>  this feature is, 1) some dwarf-aided ability to specify watched va=
riables in
>>>  the perf record command (e.g. perf record --groupby=3D"::var1,
>>> class1::staticvar2" ),
>>> and 2) provide an API to the applications so they can
>>>  communicate with perf_events telling what's going on, such as the =
example we
>>>  are showing here (which is *just* an example to fuel this discussi=
on). This
>>>  API would lead to intrusively mess the code of the app but not mor=
e than
>>>  people already do with debugging printfs; this would be very impor=
tant for
>>>  performance-centric applications.
>>
>> perf probe has an ability to reference variables relative
>> to a register or in a register, and parse dwarf for it.
>>
>> I'm not sure it's a good idea to have a lot of arbitrary memory
>> accesses in the PMI handler (although there is already some for stac=
k
>> walking)
>>
>> One problem with global variables is that they can move
>> around with ASLR, so it can be difficult to find them.
>>
>> If the variable is in a register you can already get it from the PEB=
S
>> record on Intel CPUs.  There is no good tooling for it currently,
>> but the information is in perf script output, and can be enabled
>> for perf record.
>>
>> An easy way to implement it would be to use a
>> global register variable (register asm("...") ...).
>> However you would need to rebuild all your libraries to preserve
>> the global register.
>>
>> Best would be to use an unused register. One that comes to
>> mind on x86-64bit Linux is GS, which is normally only used by the ke=
rnel.
>
> I kept thinking about all this, and I changed my mind towards a
> simpler (a first step) yet useful approach.
> In the same way people spread some printfs for old school debugging, =
I
> keep the idea of some perf API made available
> for the application (which calls depend on some flag, say -DNPERF
> similar to -DNDEBUG, so if the macro is
> not defined, calls have no effects).
> The first relatively easy (again, but yet useful) feature that comes
> to my mind, is the ability (from the app) to
> label phases of the perf recording, including enabling, disabling, an=
d
> labelling.
> For example, let's suppose that an application has an initialization
> phase, then a communication with a server,
> then data gathering, then processing, then storing the processed
> results. Currently, all the recording and reporting would mix all tha=
t
> measured information, whereas we could be interested in some phases
> only (or disabling the rest).
>
> Thus, the API could have:
>
> perf_enable();
> perf_disable();
> perf_label(const char* label);
>
> So, the application would appropriately call those functions; at
> reporting, both a summary and a breakdown of analysis would be
> performed.
> A quick hack that comes to my mind is that perf_label just changes th=
e
> destination file of perf record, closing the previous file and openin=
g
> (potentially appending)
> the specified in the argument. This way I think perf report could be
> left unmodified, so the user would just do perf report
> [labelled_file].
>
> The communication from the application to perf_events (when enabled
> with e.g. compiled wih NPERF) could be through some /proc/perf or any
> other mechanism.

One more thing to add: I think this API would actually communicate
with the perf user space tool rather than with the kernel perf_events.


>
>>
>> With this pending patchkit[1] the application can write to it
>> using WRGSBASE, previously it needed a syscall.
>
> -ENOLINK
>
>>
>> Currently perf cannot log GS I believe, but that would be fairly
>> easy to add. Would also need some tooling to make the value
>> an extra sort key in perf report.
>>
>> -Andi
>>
>
> Thanks Andi.
>
>    Daniel.
>
>
> --
>
> Daniel F. Gutson
> Engineering Manager
>
> San Lorenzo 47, 3rd Floor, Office 5
> C=C3=B3rdoba, Argentina
>
> Phone:   +54 351 4217888 / +54 351 4218211
> Skype:    dgutson
> LinkedIn: http://ar.linkedin.com/in/danielgutson



--=20

Daniel F. Gutson
Engineering Manager

San Lorenzo 47, 3rd Floor, Office 5
C=C3=B3rdoba, Argentina

Phone:   +54 351 4217888 / +54 351 4218211
Skype:    dgutson
LinkedIn: http://ar.linkedin.com/in/danielgutson
