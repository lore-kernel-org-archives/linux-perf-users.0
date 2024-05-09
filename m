Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A889929A2;
	Thu,  9 May 2024 20:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715288123; cv=none; b=dCt0nkP/sV+rUuSlspF/icX8WL9oHG2u2oNWbuuLXUaDiMEEqTta6g54Lq2B7hiS6uc690TLeQn/sVKlVuUTs0eI0QMCtHCShvupEufFwMDZAYzSlCXN3q8hEhGjd14ybcF9JEbY+RRhsDYcH6QfHdOZiudhXq+P8iU1QC250QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715288123; c=relaxed/simple;
	bh=+z3b5cB5EyGsqbqTU1g9z3SO/tunSYPElHlQobnABqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KxCjd6Yvq3GYYa7EXiwr3LTez8hlqEOEZb+dcQBl9bQjFgBFmpRC9i0R7Wn32jPOSP08WzqsG2Bj4AsHbq2301ha5gJ09DviQ3def1mjiubMrfTEr5Pj8OqaS3AR9dvOoeC+rmKh/UdgU81/FXhSblbouCMDjBHcJElxn5eBUSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-61c4ebd0c99so886867a12.0;
        Thu, 09 May 2024 13:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715288121; x=1715892921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SeDxTMUgi4LQzDaIf3nLrPy70uwzF3gPdETUheci2c=;
        b=tDarZ46XqqG/J2CiASJK7GgslLGKwsX/WGGLboIEHQ+yAFf/JLeG+IIqTgXryWZOm6
         YP8RyS7Kh84jNklaz8iWRfCE3hCQcsB3DK/sw6riyGBg10BhlGoHslNkZKXbA/6b30vM
         dDDyfZL8oKXobyO148Ox5CcaXllGGD1h6OlYYCbMbrMiwCGJ5gYagdonlsDIdVoJaaMw
         gP9Gwr2uyzvlUJZN5Ee1Wb8kF1f/tdjQIGY395kzEtjy4GXWdEj4Q2iCBlesJghrVSyh
         AzjnOd3/uzuZDd5XEh6i8lzeV7dt/rqUSfUHK2NG9e+V+syemcXth8O2LwEBfako5HTS
         /AzA==
X-Forwarded-Encrypted: i=1; AJvYcCWkYv9vDTykHQ9uTNuiz1N7PAw+hYDH0UdEHeCaVxXf76yLtwdIpX6YfDs2EIu728E6wyBfNe0B1MQN9b1JEEtJaQzBuPa+xwQFFI3ht3z+q4hHoagtCFakOlPBZPEaynxg2r6RlgYl3lJqK4PpoQ==
X-Gm-Message-State: AOJu0Yx4F1r3vhjupCCmJveaGQn+hfS9i2zS/5sRZ96kcO/utCLC2e6z
	aIZrinx2yNhm5/ViiPczfv9ULQNKrWOGhPWiZ4WJZ7rL39FVCxtBafU7C37EnJT2uwDMmOoKQ+q
	jMBRL7c7v4esov+aBXp8iI8lkYxU=
X-Google-Smtp-Source: AGHT+IGt7dUBfj7vMg0wI6ai8p0bGzNoXrhnZsLwOgnLclMfrb2jDrhK/Kigc+vuxjYxxWNl1dT8N/6AVYpASWN8wPY=
X-Received: by 2002:a17:90a:db97:b0:2b2:7e94:4073 with SMTP id
 98e67ed59e1d1-2b6cc76d73cmr727950a91.14.1715288121009; Thu, 09 May 2024
 13:55:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240506121906.76639-1-atrajeev@linux.vnet.ibm.com>
 <20240506121906.76639-5-atrajeev@linux.vnet.ibm.com> <f2efdb9d-e636-4678-b492-83d3a28d8134@csgroup.eu>
 <E21FF3FD-1080-4A6C-99B0-7239AD831532@linux.vnet.ibm.com>
In-Reply-To: <E21FF3FD-1080-4A6C-99B0-7239AD831532@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 9 May 2024 13:55:09 -0700
Message-ID: <CAM9d7cjz-_6m7mPATeRETFudz8+u=JYw20Kn6WutEKZ2f6VUyg@mail.gmail.com>
Subject: Re: [PATCH V2 4/9] tools/perf: Add support to capture and parse raw
 instruction in objdump
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Ian Rogers <irogers@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, 
	"segher@kernel.crashing.org" <segher@kernel.crashing.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "maddy@linux.ibm.com" <maddy@linux.ibm.com>, 
	"kjain@linux.ibm.com" <kjain@linux.ibm.com>, 
	"disgoel@linux.vnet.ibm.com" <disgoel@linux.vnet.ibm.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"akanksha@linux.ibm.com" <akanksha@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 10:27=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
>
>
> > On 7 May 2024, at 3:05=E2=80=AFPM, Christophe Leroy <christophe.leroy@c=
sgroup.eu> wrote:
> >
> >
> >
> > Le 06/05/2024 =C3=A0 14:19, Athira Rajeev a =C3=A9crit :
> >> Add support to capture and parse raw instruction in objdump.
> >
> > What's the purpose of using 'objdump' for reading raw instructions ?
> > Can't they be read directly without invoking 'objdump' ? It looks odd t=
o
> > me to use objdump to provide readable text and then parse it back.
>
> Hi Christophe,
>
> Thanks for your review comments.
>
> Current implementation for data type profiling on X86 uses "objdump" tool=
 to get the disassembled code.
> And then the objdump result lines are parsed to get the instruction name =
and register fields. The initial patchset I posted to enable the data type =
profiling feature in powerpc was using the same way by getting disassembled=
 code from objdump and parsing the disassembled lines. But in V2, we are in=
troducing change for powerpc to use "raw instruction" and fetch opcode, reg=
 fields from the raw instruction.
>
> I tried to explain below that current objdump uses option "--no-show-raw-=
insn" which doesn't capture raw instruction.  So to capture raw instruction=
, V2 patchset has changes to use default option "--show-raw-insn" and get t=
he raw instruction [ for powerpc ] along with human readable annotation [ w=
hich is used by other archs ]. Since perf tool already has objdump implemen=
tation in place, I went in the direction to enhance it to use "--show-raw-i=
nsn" for powerpc purpose.
>
> But as you mentioned, we can directly read raw instruction without using =
"objdump" tool.
> perf has support to read object code. The dso open/read utilities and hel=
per functions are already present in "util/dso.c" And "dso__data_read_offse=
t" function reads data from dso file offset. We can use these functions and=
 I can make changes to directly read binary instruction without using objdu=
mp.
>
> Namhyung, Arnaldo, Christophe
> Looking for your valuable feedback on this approach. Please suggest if th=
is approach looks fine

Looks like you want to implement instruction decoding
like in arch/x86/lib/{insn,inat}.c.  I think it's ok to do that
but you need to decide which way is more convenient.

Also it works on the struct disasm_line so you need to
fill in the necessary info when not using objdump.  As
long as it produces the same output I don't care much
if you use objdump or not.  Actually it uses libcapstone
to disassemble x86 instructions if possible.  Maybe you
can use that on powerpc too.

Thanks,
Namhyung

>
>
> Thanks
> Athira
> >
> >> Currently, the perf tool infrastructure uses "--no-show-raw-insn" opti=
on
> >> with "objdump" while disassemble. Example from powerpc with this optio=
n
> >> for an instruction address is:
> >
> > Yes and that makes sense because the purpose of objdump is to provide
> > human readable annotations, not to perform automated analysis. Am I
> > missing something ?
> >
> >>
> >> Snippet from:
> >> objdump  --start-address=3D<address> --stop-address=3D<address>  -d --=
no-show-raw-insn -C <vmlinux>
> >>
> >> c0000000010224b4: lwz     r10,0(r9)
> >>
> >> This line "lwz r10,0(r9)" is parsed to extract instruction name,
> >> registers names and offset. Also to find whether there is a memory
> >> reference in the operands, "memory_ref_char" field of objdump is used.
> >> For x86, "(" is used as memory_ref_char to tackle instructions of the
> >> form "mov  (%rax), %rcx".
> >>
> >> In case of powerpc, not all instructions using "(" are the only memory
> >> instructions. Example, above instruction can also be of extended form =
(X
> >> form) "lwzx r10,0,r19". Inorder to easy identify the instruction categ=
ory
> >> and extract the source/target registers, patch adds support to use raw
> >> instruction. With raw instruction, macros are added to extract opcode
> >> and register fields.
> >>
> >> "struct ins_operands" and "struct ins" is updated to carry opcode and
> >> raw instruction binary code (raw_insn). Function "disasm_line__parse"
> >> is updated to fill the raw instruction hex value and opcode in newly
> >> added fields. There is no changes in existing code paths, which parses
> >> the disassembled code. The architecture using the instruction name and
> >> present approach is not altered. Since this approach targets powerpc,
> >> the macro implementation is added for powerpc as of now.
> >>
> >> Example:
> >> representation using --show-raw-insn in objdump gives result:
> >>
> >> 38 01 81 e8     ld      r4,312(r1)
> >>
> >> Here "38 01 81 e8" is the raw instruction representation. In powerpc,
> >> this translates to instruction form: "ld RT,DS(RA)" and binary code
> >> as:
> >> _____________________________________
> >> | 58 |  RT  |  RA |      DS       | |
> >> -------------------------------------
> >> 0    6     11    16              30 31
> >>
> >> Function "disasm_line__parse" is updated to capture:
> >>
> >> line:    38 01 81 e8     ld      r4,312(r1)
> >> opcode and raw instruction "38 01 81 e8"
> >> Raw instruction is used later to extract the reg/offset fields.
> >>
> >> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> >> ---
>
