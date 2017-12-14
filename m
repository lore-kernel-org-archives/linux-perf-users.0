From: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] perf test shell: Fix check open filename arg using
 'perf trace
Date: Thu, 14 Dec 2017 13:08:45 +0100
Message-ID: <ab23fe42-1080-a46b-503e-744e097f414f@linux.vnet.ibm.com>
References: <alpine.LRH.2.20.1712081845230.9416@Diego>
 <20171211154312.GC2221@redhat.com> <20171211170750.GE3958@kernel.org>
 <alpine.LRH.2.20.1712120133380.9416@Diego> <20171212145707.GL3958@kernel.org>
 <20171212151948.GN3958@kernel.org> <alpine.LRH.2.20.1712121723290.9416@Diego>
 <20171212171259.GQ3958@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171212171259.GQ3958@kernel.org>
Content-Language: en-IE
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On 12/12/2017 06:12 PM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Dec 12, 2017 at 05:24:43PM +0100, Michael Petlan escreveu:
>> Hey Arnaldo, this one did not remove the s390x hack and also, won't work
>> on arm. Please use the one I just have sent, few seconds ago...
> 
> Ok, I have you latest in, with the cset log I wrote, which clarifies
> that this is not a arch issue, but a glibc one, its only that some
> arches have distros where glibc was already at 2.26, where open() calls
> are mapped to openat() syscalls.
> 
> - Arnaldo
> 
>> On Tue, 12 Dec 2017, Arnaldo Carvalho de Melo wrote:
>>> Em Tue, Dec 12, 2017 at 11:57:07AM -0300, Arnaldo Carvalho de Melo escreveu:
>>>> So the patch below does the trick for me, can you please check if does
>>>> for you?
>>>
>>> So I've put this with a long explanation at:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/core&id=ba15be2acc9e35dc9f034fef3aa292406b518b04
>>>
>>> - Arnaldo
>>>
> 

I have extracted the latest patch with commit id 6c23b4f 
("perf test shell: Fix check open filename arg using 'perf trace'") from the git
repository perf/core today and it works for me.


-- 
Thomas Richter, Dept 3303, IBM LTC Boeblingen Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
