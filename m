Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB0B3E63AC
	for <linux-perf-users@vger.kernel.org>; Sat,  5 Sep 2026 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788603256; cv=pass; b=CvCQLI++v9sy7O8VlryEx2WXMbVgjvti3lbUIeyYan2vvf3qhOAX15VroB6uaKKEcfKDlYTnnmbZCYImd/69tlNJFtbfAqQ05XI2KmY0/WgKBdFS3dclsCaslG/m2H6YyhAcS//iNjPKvu/JMsLKKiIgXe+Z261ErMZSqOkRC10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788603256; c=relaxed/simple;
	bh=flIXJwBBZsoHSh3njFuEraTLns1LUaYrdBRJbhubjmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H19kSYHOW3uMi3Ifex+rp1Ji5ywDU4gQCnO/0/rAkoYkJ1bJa8Vo5T440yGyPwUprx0VDk+zL2RPTt3i/7StfDZLeOWn4F7q5LNSgLuzB8tolux3er46IHmI6LTY/EhBLbsWoEqipzKWIHFZ5QzAzm6/b4FS0y/sZDvYGuwdKr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dd/J0q7C; arc=pass smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dd/J0q7C"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7777fa8f1ccso697504137.3
        for <linux-perf-users@vger.kernel.org>; Sat, 05 Sep 2026 03:14:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788603254; cv=none;
        d=google.com; s=arc-20260327;
        b=NclKYwdz2FfwN8KpPUZ0YX4be0aRmDRQY7VwBwQoakKQTssJXv7GLQ0bWOb5GXXIab
         oCvpaYfx57b4VRnBtRCULeupHi4ZGkT2RJVoCbMjTYNOl51E06j211CPC/G1fDI69Iej
         s4cFG1w+4+pqiwoq+yyAGOmifQWw3zXeL97S1szJRdA5HpJQ84ZiJhi9DOoFYVMPE/nT
         jSUOiJiZsBDjGCDtnFmya5wrXOG8o/nZG6aNL+Cyu0QVQauDbAcjBg8wNPBT5146gZ8e
         4Us/olWB3c2nG1xpX0jMD5aBRpplMCf4du5iaxM8e1ryMrYRi/g5uzG7g3pwrqfLOw7w
         DqFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bVToITECWbqQ6/dlDZL9N9UP3l41wgf3/rZHZ5NecJM=;
        fh=TLQ4XBz1SEYtF1MxkKO+e8xe6gk144f6xM2DNOYNHJs=;
        b=ox5yvEJauINObZ1DwTxdPGm/Wns+vM4t0KkMQZXCmN8ArBlA2Rq3cbd4aszPtfpiGG
         8r8yJpIEFSUQjhaI0BTpfO/K8B2DLH0j4taWXKYFD7pfnxq+e1KVH/gGzyJ/Kufh5wlH
         pSe8a5YJtZWs+sjwWsy7/N90o76+dX5on66eDxucQgr6P1Kfzew9xF+s0G6VTYdQe7s6
         PQtTEZSNrm2gI2tU+F8Ksk1YmYuiCy9dHIA7Y3sKpMQjAWOUdoN9YOCT3Va5oaBdtB2z
         xK4vfbWUYNBOb/syHXl8AHGpDU50LZh4Pm80LzasUc1lIIDV0mabQvnvM5w5qo2dlNeH
         4b6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788603254; x=1789208054; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bVToITECWbqQ6/dlDZL9N9UP3l41wgf3/rZHZ5NecJM=;
        b=Dd/J0q7Cq34xSCiVlmykZFNLyO2MfijR7k+hm+NtMN5hFSDjTLvgnoH6FvbqFhu+fX
         qTFLi5nLDY6f36lYreJ7XBpNHho9n+u5vwf010LHjJ/ljbONRgsskIOOvHzJO0R5p0u/
         ZySREmRpxbDgEx8g36mHCKa1Tzm/7Qu4DJwhsjY4nEHP8bGQNT3UOL0HXLNlL+xqSC1W
         dlXlxVB5+nOd0qEeluJWI4JbC3QBTNip7fz7ufPoJ0ClcE/5Z/j8PglU5+8VbrbkkV8f
         Gy7XHYwLlYG77f61KnQVfWmdGY1XJ/zcs5gul72y79MNpni+idVN6ue+gMVsBI4H28fL
         Veeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788603254; x=1789208054;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bVToITECWbqQ6/dlDZL9N9UP3l41wgf3/rZHZ5NecJM=;
        b=LGnAfPJnUisYCpzsrKp+547pcLXLX1v+YUopE+VAy0beRdhsinwwKa36Zie0Mhq47W
         bPmVlvQ5uxPwpM1rDWV4QDvGiOE1mmYV0E6vtGWCtfbrgLUcM8awfPY9SUnNXGIZgghg
         byzNnjI8xSf1psyycN7WckBV4tJLquDMKGXU/4JHdxWy0xckpr+KOVKA7Nb4Fsl9lo2F
         ESk1VznVXHjF+4prhGNq94UQXavI5E/Z8w4bbu/Rl9P8TrQCP4kMavYm3YEhRqPcYvMf
         8lIfwOSwuHrmJ0i9+XYtkin4JNy+j/ev13q9YCVzJW09eQlf0xxa+Y3a5PzyItxV5EnG
         JWQQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMMxlOCWjUFRk4TWzru6diWXNlATzbqFvAwkIu3OHakz5fDtxzScDJSfwISIwYICBQ5h3c3ZGgiLFzoxS+iAM1@vger.kernel.org
X-Gm-Message-State: AFuF++lpRjW3EamSaIJhVzaN55xWiqYw8hufKd5wAHgU3tZtGTJWXFur
	yrS36BIeeb/3peWoHEh/3c9J1qCvYGL+yG4AcvZmIy//CLJyl04WF+6caDkNpW6JQwDmYb0Z4Tg
	FEujqvAcUfg1jIb2/D/26PlfTeq3qZtY=
X-Gm-Gg: AYBFou0qkkhQqKVWjvG7ECi74L7kIMLC9IGPH3cwTDvsmVbOq6ySy8ro7LqCME5c6l+
	GiPgbcASlR1o1mS1ErG2s/VXqVkfI/bDnDh3+jT24Qklh4a9WjAzsN+bsL5fEaB6v+XgGLa/R55
	ZjwcGW8s27ev5o85+Fg/+tG1Jp6fS5F6fid6/w38s+MspdEeDkbNCt5Gw81mkfWN2jFBQGAPUFk
	xB7fF0isRgyL/5kwOU0h6oMYEgmnrtjfW3aBWKlAItcbkY36W4SOqmQYyJ1kJ/NMS5wN2bHpQUW
	/y6M//lW1FIYMtZ6nAtrmNfJpNbPilaSxX4SWsVguFANohPZAwP3+gLBDi8yAlFVamc/qGNj9ZO
	DmoC4c+RebgGRYLMH/jFauIjn7Wzq9lbuyQ==
X-Received: by 2002:a05:6102:292b:b0:782:e19d:6f39 with SMTP id
 ada2fe7eead31-78a4a483c93mr3569840137.0.1788603254118; Sat, 05 Sep 2026
 03:14:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPu-DQqF0aF6=GS8Z6KKWeeX_V5LiXeKU_rJQZC+uGg8zuTPNw@mail.gmail.com>
 <apCyQ93c48Dy4H-S@google.com> <apG-RzV0zyjoC-FY@google.com>
 <27d79477-c469-413b-95bd-c6c1f8a40f55@amd.com> <apbs8gywyAfFVzqm@google.com>
 <c38b254f-21e5-4a02-8934-7a4da61e4571@linux.intel.com> <7b4cba95-dacc-4cf1-953f-c59e06e693d0@amd.com>
 <a5d3798c-7d62-43d0-88c6-eec26bd4f63d@linux.intel.com> <0e5e1fd0-0a46-4c1c-a391-5c245d903834@amd.com>
 <f0e05b97-1cce-427b-a56c-57a031cfe1ac@linux.intel.com>
In-Reply-To: <f0e05b97-1cce-427b-a56c-57a031cfe1ac@linux.intel.com>
From: Gennady Kupava <gennady.kupava@gmail.com>
Date: Sat, 5 Sep 2026 11:14:03 +0100
X-Gm-Features: AcwNN1X4xynYubq9aSauwkMXuC3NfQlZ_vT8m3h2fp7AkG5GAFSAzfkeR-kovjw
Message-ID: <CAPu-DQoZUHN+76uqfEA7Jb4dS6aOBO0HHxy3heRtCVSdANVc_A@mail.gmail.com>
Subject: Re: [DISCUSSION] Three problems behind broken "perf --call-graph
 dwarf" on AMD: IP and stack dump mismatch, libdw fails on lld's layout, and
 the unwinder fallback never runs
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Ravi Bangoria <ravi.bangoria@amd.com>, Namhyung Kim <namhyung@kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, perf people!

It was really interesting to read the conversation and especially nice
to see that there would be a patch.

Yeah, did not notice --unwind-style, and for sure one of the problems i
mentioned should be resolved by that option. May be i could do patch to
document it as a small contribution.

Overall i read all replies to date - not yet deeply understood them yet,
and my plan was to write just about libunwind vs libdw question - basically all
reasoning to remove libunwind makes sense, except that biggest problem
here is that we are switching from something which is working to
something which does not, which is leading to the fact that I as a user
have to go through some challenges using perf to get proper callgraphs.
And i could guess i am not alone with that. I checked, my debian
unstable system contains latest release of libdw. It was one release
behind when i wrote mail originally, but now it is latest.

I learned now about sframes approach and it really makes me really keen
to see it implemented as a way to record callchains. Recording the
entire stack always seems extremely inefficient thing to do - but to be
fair only side-effect of that is that we could do records much less
frequently and sometimes when apps put large amount of data into stack
it doesn't work. LBR somehow never worked for me, may be i need to
explore it more.

Now I am coming to the part which seems to interesting for me, and there
i made quite a discovery which completely reversed my opinion on fp.

My personal opinion on fp always was that 'ok, fine - but how much we
all should pay for operation which even I who is executing it more than
literally any developer I know - in my normal tasks'? So, i did small
test and results been really surprising for me.

Out of the interest, i just built something real - that osmand tile
renderer I was looking at, disabled CPU boost, fixed cpu to 3 GHz, made
40 runs for each fp/no fp and dropped the slowest 10 of each. Note
system and other libs not been built with fp - so not all code paying
cost of fp (by DSO, 71% of the samples fall in the rebuilt binary).

I built my engine with clang-21 and gcc-16.

clang-21 data:

    instructions            +3.9%
    cycles                  +2.3%
    wall time               +2.3%   (30 runs)
    package energy         +2.45%   (30 runs)
    .text                  +0.35%
    L1i load misses         -7.3%
    prologues added          +32k

If I was looking just to clang I would say - hey, 2.5% for 71% of code,
could estimate 3.3% if we rebuilt whole system - my system from 32 core
reduced to 31 core and I would be paying +3.3% energy bills! Debian is
very right not enabling fp!

However then I thought, ok osmand is android project but most people in
most places actually use gcc, what about gcc-16, and ended up in being
in light shock:

    instructions            +0.8%   (1 run)
    cycles                  +0.3%   (1 run)
    wall time              -0.13%   (30 runs)
    package energy         +0.22%   (30 runs)
    .text                  -0.54%
    L1i load misses        -13.7%   (1 run)
    prologues added          +19k

So fp build is consistently faster, less cache misses!

Discussing with my invisible AI friend found the reason:

<begin of AI text>
The code got *smaller*, by 113 KB, and missed the instruction cache 14%
less often. The cause is in the instruction encoding. On x86-64 an
access through rsp needs an extra SIB byte; an access through rbp does
not, but its displacement is negative and often needs four bytes where
rsp's small positive offset fits in one. Measured over the whole binary,
the two effects leave a net saving of 0.19 bytes per stack access:

    build      via rsp              via rbp
    no FP      660,629 at 5.41 B    192,803 at 5.55 B
    with FP      3,653 at 6.00 B    824,229 at 5.22 B

which works out as -320 KB on stack references, against +77 KB of extra
prologues (19k more functions at four bytes) and +127 KB of other
codegen differences - a net -116 KB, which is what the .text figure
shows.
<end of AI text>

So actually adding fp's to me look more like optimisation (smaller code,
negligible faster runtime with negligible more energy consumed) than
paying a toll for frames, taking in account gcc is still not doing
things in quite optimal way - it could potentially use both rbp and rsp
in different locations. May be I should also suggest fairly
straightforward patch to gcc to win even more with fp enabled.

I decided to ask AI to generate gcc patch to use rsp in case if it would
save instruction code (mixed mode gcc) and did another set of runs.

Legal note: I did not look into that patch, as it seems gcc forbids
non-trivial patches derived or generated by AI, just wanted to see what
would be an effect. I feel being capable enough to write one myself -
may be will try when I have more time, it looks like this worth much
more for all my systems than any kind of perf or osmand contribution.

Data below is different from above - but this is because I've found that
part of the code is using random hashes, which introduced more spread in
the runs above. Runs below are with the random seed fixed.

CODE SIZE:

    build       .text bytes    vs nofp     vs fp
    nofp         21,467,662          -         -
    fp           21,351,934     -0.54%         -
    fp+mixed     21,194,254     -1.27%    -0.74%

STACK VAR REFERENCES:

    addressing form              nofp         fp   fp+mixed
    rbp, 1-byte displacement   92,248    489,962    489,962
    rbp, 4-byte displacement  100,555    334,267    257,752
    rbp, indexed                4,615      3,284      3,284
    rsp, no displacement       47,872        575      3,547
    rsp, 1-byte displacement  468,973      1,170     74,713
    rsp, 4-byte displacement  143,784      1,908      1,908
    rsp, indexed                3,191         66         66
    total                     861,238    831,232    831,232

INSTRUCTION COUNT:

    build     run 1           run 2           run 3
    nofp      53,817,272,410  53,831,289,203  53,820,709,477
    fp        54,747,413,314  54,749,169,058  54,740,499,791
    mixed     54,745,775,977  54,748,063,729  54,743,584,686

    build     mean            spread   vs nofp    vs fp
    nofp      53,823,090,363  0.026%        -        -
    fp        54,745,694,054  0.016%   +1.71%        -
    mixed     54,745,808,131  0.008%   +1.71%   +0.00%

PERFORMANCE, best 10 of 20 by time:

    build     time ms     sd   energy J     sd   vs nofp    vs nofp
                                                    time     energy
    nofp       5721.2   48.6      228.4    2.4         -          -
    fp         5683.6   71.9      227.3    2.9    -0.66%     -0.47%
    mixed      5728.7   33.0      228.9    1.0    +0.13%     +0.22%

Now only question why smaller code runs slower - and further analysis
seems to show that this a bit random - mostly due to cache layout for
this specific task.

So my overall conclusion from this is:

1) enabling fp on amd64 on gcc is net zero cost in performance, less
   code size -> net benefit. Very surprising. Nice.

2) makes sense to write and create patch to gcc for mixed addressing
   (shifting rbp also makes sense, but that is ABI change)

3) why would anybody need sframes or whatever if fp is actually benefit?

Hope I did not miss anything interesting, will try to understand other
things in thread as next dive =)

Regards,
Gennady

On Fri, 4 Sept 2026 at 01:22, Mi, Dapeng <dapeng1.mi@linux.intel.com> wrote:
>
>
> On 9/4/2026 12:02 AM, Ravi Bangoria wrote:
> >> Suppose we need to follow below 2 rules to ensure the correct call-chain
> >> unwinding and register snapshot consistency.
> >>
> >> 1. All registers including IP should come from either PEBS or PMI, must not
> >> be mixed. This ensures to get an consistent registers snapshot.
> >>
> >> 2. Either SAMPLE_CALLCHAIN or SAMPLE_STACK_USER is required, the PMI
> >> registers snapshot must be used. This proves the correct DWARF unwinding.
> >>
> >> How's your idea?
> > Looks good. Mind sending the patch?
>
> Yep, let me cook the patches. Thanks.
>
>
> >
> > Thanks,
> > Ravi
