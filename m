From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: perf tools build broken after v5.1-rc1
Date: Thu, 2 May 2019 10:10:15 -0700
Message-ID: <506c2df7-4088-9a18-91c0-c86b944714da@synopsys.com>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A250584C@us01wembx1.internal.synopsys.com>
 <CAK8P3a2JrAApXDws+t=q8AnKFkHJZSox7gsgwW-xEJTfs_mdzw@mail.gmail.com>
 <20190501204115.GF21436@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A2506BF3@us01wembx1.internal.synopsys.com>
 <20190502143618.GH21436@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A2506D04@us01wembx1.internal.synopsys.com>
 <20190502164104.GB23984@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190502164104.GB23984@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rich Felker <dalias@libc.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, lkml <linux-kernel@vger.kernel.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, arcml <linux-snps-arc@lists.infradead.org>
List-Id: linux-perf-users.vger.kernel.org

On 5/2/19 9:41 AM, Arnaldo Carvalho de Melo wrote:
>> While this takes care of immediate issues, for the long term, are you open to idea
>> of removing the header duplicity.
>
> In the beginning we used the kernel headers directly, then, acting on
> advice/complaints from Linus about tooling breaking when changes were
> made in the kernel sources we were using directly, we moved to have
> copies and notice when things change so that we could think about what
> changed and act accordingly, without putting the burden to the kernel
> developers to keep tools/ building, I want to keep it that way.

Sure, and the reduced duplicity I propose doesn't change that in any way. The onus
is still on perf maintainers to copy over any unistd changes - in the new regime,
it will be just lesser since we only care about a handful of syscalls, not the
entire unistd.


> Now you say, validly, that there are bits that are designed to be used
> by userspace, so for those, we should go back to not copying and using
> it direcly, elliminating the duplicity you don't like.

Indeed.

> I don't know, I'm used to the duplicity and the checks,

:-)

> not breaking
> tools even when kernel developers make mistakes in the UAPI headers,

Not sure how replacing the full header with just a small hunk, out of same header
out-of-line will change anything or cause any more breakage.

> tools/perf is self container wrt the latest and greatest stuff not
> present in older environments, and the onus is on perf developers to do
> the sync.

Sure it is, I'm proposing to make their work less, no more.


> This specific issue here happened because I made a mistake, which I
> fixed when reported,

Exactly, it was a genuien mistake with a super prompt followup - your promptness
is really appreciated and emulation worthy for other maintainers including myself ;-)

> now I have three containers for cross building for
> ARC, two versions for the uCLibc based toolchain, one for the glibc one,
> libnuma, elfutils and zlib are cross build there, so should make it less
> likely problems like this will happen again.

Ok, well lets leave it at that for now then.


>> We could use a "less evil" idiom of copying only the minimal bits (since the sync
>> onus remains one way or the other)
>> e.g. I spotted below in bpf code and also seen in other ah-hoc multi arch projects
>  
>> #ifdef __NR_xx
>> # if defined (__arch_y__)
>>
>> # elif defined (__arch_z__)
>>
>> # endif
>> #endif

Thx,
-Vineet
