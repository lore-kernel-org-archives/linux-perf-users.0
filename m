From: peter enderborg <peter.enderborg@sony.com>
Subject: Re: Scheduler benchmarks
Date: Tue, 18 Aug 2020 20:15:26 +0200
Message-ID: <84362b8b-971f-fb89-115d-41d2457c24fd@sony.com>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com>
 <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com>
 <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
 <20200818173656.GA748290@kroah.com>
 <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Muni Sekhar <munisekharrms@gmail.com>, Greg KH <greg@kroah.com>
Cc: kernelnewbies <kernelnewbies@kernelnewbies.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 8/18/20 7:53 PM, Muni Sekhar wrote:
> On Tue, Aug 18, 2020 at 11:06 PM Greg KH <greg@kroah.com> wrote:
>> On Tue, Aug 18, 2020 at 11:01:35PM +0530, Muni Sekhar wrote:
>>> On Tue, Aug 18, 2020 at 10:44 PM Greg KH <greg@kroah.com> wrote:
>>>> On Tue, Aug 18, 2020 at 10:24:13PM +0530, Muni Sekhar wrote:
>>>>> On Tue, Aug 18, 2020 at 8:06 PM Greg KH <greg@kroah.com> wrote:
>>>>>> On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> I’ve two identical Linux systems with only kernel differences.
>>>>>> What are the differences in the kernels?
>>>> You didn't answer this question, is this the same kernel source being
>>>> compared here?  Same version?  Same compiler?  Everything identical?
>>> Both systems are having exactly the same hardware configuration.
>>> Compiler and kernel versions are different. One system has Ubuntu
>>> 16.04.4 LTS(4.4.0-66-generic kernel with gcc version 5.4.0) kernel and
>>> the other one has Ubuntu 18.04.4 LTS(4.15.0-91-generic kernel with gcc
>>> version 7.5.0).
>> Those are _very_ different kernel versions, with many years and tens of
>> thousands of different changes between them.
>>
>> Hopefully the newer kernel is faster, so just stick with that :)
> But unfortunately the newer kernel is very slow, that is the reason
> for starting this investigation :)
> Any type of help,  and guidelines to dive deeper will be highly appreciated.

On the 4.4 kernel you dont have

+CONFIG_RETPOLINE=y
+CONFIG_INTEL_RDT=y

And your base is very different two.

Try to use mainline on both system and see.

You can also use the same base kernel version from ubuntu and

run your test.


>> greg k-h
>
>
