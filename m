From: Daniel Gutson <daniel.gutson@tallertechnologies.com>
Subject: Re: Ability for classifying of measurements\
Date: Wed, 4 May 2016 14:20:37 -0300
Message-ID: <CAF5HaEXP1vvDod5eRnY2DYvTzeZDC_w15SbNpPEdosbv52qbAQ@mail.gmail.com>
References: <1461099117-21401-1-git-send-email-leonardo.boquillon@tallertechnologies.com>
	<87ega0whpq.fsf@tassilo.jf.intel.com>
	<CAF5HaEXOwn0_b=an2RR2FT++ktRXLpAP2WHPE7O=kdVKVRYKVQ@mail.gmail.com>
	<CAF5HaEW29wA6ZtNkGhTdFQGwoZp=QWaxEgt3n_7Ph+iA2YVyxQ@mail.gmail.com>
	<20160420174724.GP9407@two.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33698 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752759AbcEDRUi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 4 May 2016 13:20:38 -0400
Received: by mail-ob0-f182.google.com with SMTP id x1so24080865obt.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 May 2016 10:20:37 -0700 (PDT)
In-Reply-To: <20160420174724.GP9407@two.firstfloor.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Leonardo Boquillon <leonardo.boquillon@tallertechnologies.com>, linux-perf-users@vger.kernel.org

On Wed, Apr 20, 2016 at 2:47 PM, Andi Kleen <andi@firstfloor.org> wrote=
:
>>  Agree, this was the first step. What we would like to see implement=
ed from
>>  this feature is, 1) some dwarf-aided ability to specify watched var=
iables in
>>  the perf record command (e.g. perf record --groupby=3D"::var1,
>> class1::staticvar2" ),
>> and 2) provide an API to the applications so they can
>>  communicate with perf_events telling what's going on, such as the e=
xample we
>>  are showing here (which is *just* an example to fuel this discussio=
n). This
>>  API would lead to intrusively mess the code of the app but not more=
 than
>>  people already do with debugging printfs; this would be very import=
ant for
>>  performance-centric applications.
>
> perf probe has an ability to reference variables relative
> to a register or in a register, and parse dwarf for it.
>
> I'm not sure it's a good idea to have a lot of arbitrary memory
> accesses in the PMI handler (although there is already some for stack
> walking)
>
> One problem with global variables is that they can move
> around with ASLR, so it can be difficult to find them.
>
> If the variable is in a register you can already get it from the PEBS
> record on Intel CPUs.  There is no good tooling for it currently,
> but the information is in perf script output, and can be enabled
> for perf record.
>
> An easy way to implement it would be to use a
> global register variable (register asm("...") ...).
> However you would need to rebuild all your libraries to preserve
> the global register.
>
> Best would be to use an unused register. One that comes to
> mind on x86-64bit Linux is GS, which is normally only used by the ker=
nel.

I kept thinking about all this, and I changed my mind towards a
simpler (a first step) yet useful approach.
In the same way people spread some printfs for old school debugging, I
keep the idea of some perf API made available
for the application (which calls depend on some flag, say -DNPERF
similar to -DNDEBUG, so if the macro is
not defined, calls have no effects).
The first relatively easy (again, but yet useful) feature that comes
to my mind, is the ability (from the app) to
label phases of the perf recording, including enabling, disabling, and
labelling.
=46or example, let's suppose that an application has an initialization
phase, then a communication with a server,
then data gathering, then processing, then storing the processed
results. Currently, all the recording and reporting would mix all that
measured information, whereas we could be interested in some phases
only (or disabling the rest).

Thus, the API could have:

perf_enable();
perf_disable();
perf_label(const char* label);

So, the application would appropriately call those functions; at
reporting, both a summary and a breakdown of analysis would be
performed.
A quick hack that comes to my mind is that perf_label just changes the
destination file of perf record, closing the previous file and opening
(potentially appending)
the specified in the argument. This way I think perf report could be
left unmodified, so the user would just do perf report
[labelled_file].

The communication from the application to perf_events (when enabled
with e.g. compiled wih NPERF) could be through some /proc/perf or any
other mechanism.

>
> With this pending patchkit[1] the application can write to it
> using WRGSBASE, previously it needed a syscall.

-ENOLINK

>
> Currently perf cannot log GS I believe, but that would be fairly
> easy to add. Would also need some tooling to make the value
> an extra sort key in perf report.
>
> -Andi
>

Thanks Andi.

   Daniel.


--=20

Daniel F. Gutson
Engineering Manager

San Lorenzo 47, 3rd Floor, Office 5
C=C3=B3rdoba, Argentina

Phone:   +54 351 4217888 / +54 351 4218211
Skype:    dgutson
LinkedIn: http://ar.linkedin.com/in/danielgutson
