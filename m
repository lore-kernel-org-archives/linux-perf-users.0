From: Gary Byers <gb@clozure.com>
Subject: Re: odd error from "perf record"
Date: Tue, 19 Jan 2016 18:31:55 -0700
Message-ID: <569EE38B.7060606@clozure.com>
References: <569957F9.80700@clozure.com> <20160115211751.GI18367@kernel.org>
 <569AAE55.8090902@clozure.com> <20160119221437.GJ27085@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from gyp.clozure.com ([74.50.56.54]:36655 "EHLO gyp.clozure.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934679AbcATBb6 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 19 Jan 2016 20:31:58 -0500
In-Reply-To: <20160119221437.GJ27085@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org



On 01/19/2016 03:14 PM, Arnaldo Carvalho de Melo wrote:
> Em Sat, Jan 16, 2016 at 01:55:49PM -0700, Gary Byers escreveu:
>> thanks.  I can work around the problem described in my previous message, but
>> the problem
>> that I describe below is harder for me to describe and I  don't know exactly
>> where the
>> problem might be and of course don't know how to work around it
>   
>> The code that I am trying to profile is written in Clozure Common Lisp (CCL(
>> <http://ccl.clozure.com>.
>> the memory regions that I am most interested in profiling contain lisp code;
>> other regions mapped by
>> the process are mapped to ELF files which do not seem to exhibit problems.
>>
>> the problems that I am most concerned about involve profiling compiled Lisp
>> code, and a (somewhat
>> rambling) description of that problem and steps to reproduce it follows.
>>
>> A copy of /proc/<pid>/maps for a running CCL process is enclosed as
>> "mail.txt", the memory map
>> shown in that file is "typical" of a CCL process but may not be as typical
>> of programs written
>> in other development systems.
>>
>>
>>
>> I would like to be able to use "perf record ..." and "perf report" to
>> profile that
>> code, and was able to do so for many years.  the details of how I was able
> If so, would it be possible for you to use 'git bisect' on a kernel that
> works with a recent kernel sources so that you can go on building just
> the tooling side and testing it to check if the problem is tooling
> related?
>
> Or have you checked that already, i.e. is it a single perf tool version
> with different kernel that causes the problem?
>
> I use these scripts to do a git bisect run, i.e. automated bisection:
>
> [acme@zoo ~]$ cat ~/bin/mbisect
> #!/bin/bash
>
> rm -rf /tmp/build/perf ; mkdir -p /tmp/build/perf ; make O=/tmp/build/perf -C tools/perf install-bin > /tmp/log.m 2>&1 || exit 125
> ptest $1
> [acme@zoo ~]$ cat ~/bin/ptest
> #!/bin/sh
>
> perf test $1 2>&1 | grep -q Ok$
>
> ------------------------
>
> Just replace that ptest one with whatever you have that returns 0 for ok, 1 for
> problems.
>
> bisecting the kernel is possible but takes longer as reboots will have to be
> performed.
>
>> to do so
>> are (probably) not relevant, but did not involve a /tmp/<pid>/map file when
>> I used
>> earlier Linux kernels
> Define "earlier", what version?


I started noticing the problem after upgrading from Ubuntu 14.10 and 
Linux 3.13.x
to Ubuntu 15.04 and Linux 3.19.

I have a version of the .image file that I created "the old way", using 
some utilities
defined in libelf.so to try to fool perf into believing that the memory 
regions were
mapped by the dynamic linker.  The "file" command is at least partly fooled

~] gb@abq> file perfccl.image
perfccl.image: ELF 64-bit LSB shared object, x86-64, version 1 (SYSV), 
statically linked, not stripped

and I suspect that the point where things seem to have stopped working 
may be around the time
that perf stopped  being fooled by this.


>
>> The perf map file that I have been creating recently contains entries of the
>> form
>>
>> 000030000010D000 2411 CCL::+-2
>> 000030000010F490 25F9 CCL::--2
>> 0000300000111B10 1531 CCL::*-2
>> 00003000001130F0 2C29 CCL::/-2
>> 0000300000115DB0 1EB1 CCL::=-2
>> 0000300000117CD0 59 CCL::/=-2
>>
>> those entries were in a text file named /tmp/perf-22415.map.
>> for a process whose pid was 22415 when I ran "perf record ..."
>> the .map file contains a few thousand such entries.
> So, these will be used, IIRC, if this is an anonymous map
>
>> the output that I get from 'perf report .. "   -with or without
>> a ,map file -  looks like
>>
>>      14.97%  lx86cl64  lx86cl64           [.] zero_dnodes
>>      14.55%  lx86cl64  lx86cl64.image     [.] 0x000000000011da1d
>>      11.55%  lx86cl64  lx86cl64.image     [.] 0x000000000011da11
>>       9.34%  lx86cl64  lx86cl64.image     [.] 0x000000000011da24
>>
>> where "lx86cl64" is an ELF executable and "lx86cl64.image" is a file from
>> which
>> the memory regions described by the perf  .map file are mmapped. Note that
>> the addresses
>> in the "perf report" output do not seem to have much to do with the address
>> ranges
>> described in the perf .map file, though they might be correct in some of
>> their low bits.
> They are offsets to the map where they were found, so if you look at the
> /proc/PID/maps and add the mmap where the lx86cl64.image is + the values you
> see above, you'll get the virtual address, like you used in that
> /tmp/perf-PID.map.

thanks
>   
>> If this is indeed a problem in 'perf' or related kernel components, as it
>> appears to be, I believe that it may have been
>> introduced sometime after Linux 3.13 and sometime before 3.19.
>>
>> In the code that I was running, the entries for the code from the ELF file
>> (lx86cl64) look
>> plausible and may be correct,  The number of addresses reported for the code
>> mapped from
>> the lx86cl64.image file seems plausible. but the addresses themselves do
>> not.
> See the comment above.
>
> so, from your /proc/pid/map file, we see:
>
>> 300000000000-300000fc6000 r-xp 00002000 08:07 18350962     /usr/local/src/ccl/lx86cl64.image
>> 300000fc6000-300000fc8000 rwxp 00fc8000 08:07 18350962     /usr/local/src/ccl/lx86cl64.image
>> 300000fc8000-300001559000 r-xp 00fca000 08:07 18350962     /usr/local/src/ccl/lx86cl64.image
>> 300040000000-300040568000 rwxp 019d9000 08:07 18350962     /usr/local/src/ccl/lx86cl64.image
>> 302000000000-30200047e000 rwxp 0155b000 08:07 18350962     /usr/local/src/ccl/lx86cl64.image
> Which will make it try to find symbols in /usr/local/src/ccl/lx86cl64.image, which,
> looking at your tarball, I see as:
>
> [acme@zoo ccl]$ file lx86cl64.image
> lx86cl64.image: data
>
> So, it would have to fallback to using the method it uses for anonymous maps to
> be able to use that /tmp/perf-PID.map file, that would be the explanation for
> it to work in that distant past, that I would have to check if it would be the case...
>
> Yeah, for such a case, where you have a pathname but that pathname is not to a
> file with a symtab, we would have to save the pid in the struct map, then at
> map__load() time notice that we didn't managed to load any symtab, then try to
> do what map__new does at this point:
>
>                  if ((anon || no_dso) && type == MAP__FUNCTION) {
>                          snprintf(newfilename, sizeof(newfilename), "/tmp/perf-%d.map", pid);
>                          filename = newfilename;
>                  }
>
> Then replace map->dso with:
>
>        dso = machine__findnew_dso(machine, filename);
>
> A hack just for your usecase would be to make it think it is anonymous memory if the filename
> ends in ".image", then it would use the /tmp/perf-%d.map method.
>
> Quick hack, maybe will help you.
>
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index 171b6d1..d4d706f 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -154,7 +154,7 @@ struct map *map__new(struct machine *machine, u64 start, u64 len,
>   		int anon, no_dso, vdso, android;
>   
>   		android = is_android_lib(filename);
> -		anon = is_anon_memory(filename);
> +		anon = is_anon_memory(filename) || strstr(filename, ".image");
>   		vdso = is_vdso_map(filename);
>   		no_dso = is_no_dso_memory(filename);
>   
>
> Having it as anonymous, as you can see a little later in map__new() will
> make it a identity map:
>
>    if (anon || no_dso) {
>        map->map_ip = map->unmap_ip = identity__map_ip;
>
>
> I.e. your symtab, that /tmp/perf-PID.map can have virtual address, and unresolved
> symbols will appear not as offsets, as they are appearing now.
Thanks

Do I understand correctly that is_anon_memory()  currently returns false 
(and causes the variable anon
to be set to false), and if the memory regions were mapped differently 
when the .image file was mmapped
so that (is_anon_memory() returned true) that might have the the same 
effect on map->map_ip  and friends?

I'll look as is_anon_memory and see if it means what I think it does, 
and have a few more ideas about how
to proceed now, which is a few more ideas than I've had to this point.

Thanks again.
