From: =?windows-1252?Q?Martin_Li=9Aka?= <mliska@suse.cz>
Subject: Re: perf annotate with sample counts
Date: Thu, 16 Jul 2015 14:52:26 +0200
Message-ID: <55A7A90A.5070008@suse.cz>
References: <55A70107.3030106@us.ibm.com> <55A76492.8030203@suse.cz> <55A7A724.8010506@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38941 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048AbbGPMw3 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 16 Jul 2015 08:52:29 -0400
In-Reply-To: <55A7A724.8010506@us.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Paul Clarke <pc@us.ibm.com>, linux-perf-users@vger.kernel.org

On 07/16/2015 02:44 PM, Paul Clarke wrote:
> On 07/16/2015 03:00 AM, Martin Li=9Aka wrote:
>> On 07/16/2015 02:55 AM, Paul Clarke wrote:
>>> Is there a way to get perf annotate to display sample counts instea=
d of, or in addition to, percentages?
>>>
>>> The percentages seem relative to the function, which isn't as helpf=
ul in a global context.
>=20
>> I think you are exactly looking for: https://lkml.org/lkml/2015/6/19=
/742, which
>> I implemented couple of weeks ago :)
>=20
> Near-perfect timing, I guess!  Thanks, Martin!
>=20
> Do you have any sample output?  I don't see any in that thread.
>=20
> Isn't this function analogous to perf report's "-n, --show-nr-samples=
" option?  For consistency and usability, would it not be better to use=
 those options instead of "--show-total-period" ?
>=20
> Thanks again!
> PC
>=20

Hello.

Agree with you that it should be renamed to --show-nr-samples, I can co=
me with a patch for that.

There's samples output:
 Percent |	Source code & Disassembly of cc1plus for cycles
---------------------------------------------------------------
         :
         :
         :
         :	Disassembly of section .text:
         :
         :	000000000059c480 <ggc_internal_alloc(unsigned long, void (*)=
(void*), unsigned long, unsigned long)>:
         :	_Z18ggc_internal_allocmPFvPvEmm():
         :	      new_entry =3D alloc_page (order);
         :
         :	      new_entry->index_by_depth =3D G.by_depth_in_use;
         :	      push_by_depth (new_entry, 0);
         :
         :	      /* We can skip context depths, if we do, make sure we =
go all the
      13 :	  59c480:       push   %r15
      40 :	  59c482:       push   %r14
       9 :	  59c484:       mov    %rdx,%r15
       1 :	  59c487:       push   %r13
       0 :	  59c489:       push   %r12
      13 :	  59c48b:       mov    %rsi,%r13
       4 :	  59c48e:       push   %rbp
       5 :	  59c48f:       push   %rbx
       6 :	  59c490:       mov    %rcx,%r14
         :	ggc_round_alloc_size_1():
         :	}
         :
         :	/* For a given size of memory requested for allocation, retu=
rn the
         :	   actual size that is going to be allocated.  */
         :
         :	size_t
       5 :	  59c493:       mov    $0xa,%r12d
         :	_Z18ggc_internal_allocmPFvPvEmm():
         :	      new_entry =3D alloc_page (order);
         :
         :	      new_entry->index_by_depth =3D G.by_depth_in_use;
         :	      push_by_depth (new_entry, 0);
         :
         :	      /* We can skip context depths, if we do, make sure we =
go all the
       2 :	  59c499:       sub    $0x38,%rsp
         :	ggc_round_alloc_size_1():
         :	}
         :
         :	/* For a given size of memory requested for allocation, retu=
rn the
         :	   actual size that is going to be allocated.  */
         :
         :	size_t
      10 :	  59c49d:       cmp    $0x1ff,%rdi
       0 :	  59c4a4:       ja     59ca52 <ggc_internal_alloc(unsigned l=
ong, void (*)(void*), unsigned long, unsigned long)+0x5d2>
         :	ggc_round_alloc_size (size_t requested_size)

w/o the option:

 Percent |	Source code & Disassembly of cc1plus for cycles
---------------------------------------------------------------
         :
         :
         :
         :	Disassembly of section .text:
         :
         :	000000000059c480 <ggc_internal_alloc(unsigned long, void (*)=
(void*), unsigned long, unsigned long)>:
         :	_Z18ggc_internal_allocmPFvPvEmm():
         :	      new_entry =3D alloc_page (order);
         :
         :	      new_entry->index_by_depth =3D G.by_depth_in_use;
         :	      push_by_depth (new_entry, 0);
         :
         :	      /* We can skip context depths, if we do, make sure we =
go all the
    0.92 :	  59c480:       push   %r15
    2.83 :	  59c482:       push   %r14
    0.64 :	  59c484:       mov    %rdx,%r15
    0.07 :	  59c487:       push   %r13
    0.00 :	  59c489:       push   %r12
    0.92 :	  59c48b:       mov    %rsi,%r13
    0.28 :	  59c48e:       push   %rbp
    0.35 :	  59c48f:       push   %rbx
    0.42 :	  59c490:       mov    %rcx,%r14
         :	ggc_round_alloc_size_1():
         :	}
         :
         :	/* For a given size of memory requested for allocation, retu=
rn the
         :	   actual size that is going to be allocated.  */
         :
         :	size_t
    0.35 :	  59c493:       mov    $0xa,%r12d
         :	_Z18ggc_internal_allocmPFvPvEmm():
         :	      new_entry =3D alloc_page (order);
         :
         :	      new_entry->index_by_depth =3D G.by_depth_in_use;
         :	      push_by_depth (new_entry, 0);
         :
         :	      /* We can skip context depths, if we do, make sure we =
go all the
    0.14 :	  59c499:       sub    $0x38,%rsp
         :	ggc_round_alloc_size_1():
         :	}
         :
         :	/* For a given size of memory requested for allocation, retu=
rn the
         :	   actual size that is going to be allocated.  */
         :
         :	size_t
    0.71 :	  59c49d:       cmp    $0x1ff,%rdi
    0.00 :	  59c4a4:       ja     59ca52 <ggc_internal_alloc(unsigned l=
ong, void (*)(void*), unsigned long, unsigned long)+0x5d2>
         :	ggc_round_alloc_size (size_t requested_size)

Martin
