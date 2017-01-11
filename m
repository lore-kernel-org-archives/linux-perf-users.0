From: "Jin, Yao" <yao.jin@linux.intel.com>
Subject: Re: Feedback on: [RESEND PATCH v2 0/5] perf report: Show inline stack
Date: Wed, 11 Jan 2017 09:01:44 +0800
Message-ID: <953390cf-fb74-12ed-abea-34540ab26363@linux.intel.com>
References: <5135140.l86lTS2Zdn@agathebauer>
 <25589337.ZiVbHRJfWF@milian-kdab2>
 <780b3634-fa42-01f5-4f95-3c571fa4eb84@linux.intel.com>
 <3552078.l4qC7a8nAH@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:34187 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751584AbdAKBBq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Jan 2017 20:01:46 -0500
In-Reply-To: <3552078.l4qC7a8nAH@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>

Hi Wolff,

See my comments below

Thanks

Jin Yao

On 1/10/2017 11:03 PM, Milian Wolff wrote:
> On Tuesday, January 10, 2017 9:53:04 AM CET Jin, Yao wrote:
>> Hi Wolff,
>>
>> I update the patch series with adding inline searching for each
>> callchain entry.
> Hey Yao,
>
> great! Is your git branch publicly accessible somewhere, so I can check it
> out?
Sorry, no public git branch yet, but I will send my patch series to you 
in another mail thread.
>> Now the result tested on my skl machine is:
>>
>> # Overhead  Command  Shared Object        Symbol
>> # ........  .......  ................... ..................................
>> #
>>       56.76%  inline   inline               [.] main
>>
>>               ---main
>>                  __libc_start_main
>>                  _start
> This is still wrong, no? Tons of stuff gets inlined into main and it seems as
> if your code is still not capable of displaying what that is. Please refer to
> the output I pasted from my patch in the previous mail. I'm explicitly looking
> for the cost of using <random> e.g.
That might be not an issue. I have checked rip of each callchain entry 
and use "addr2line -e <binary> -i <rip>" to verify if it's in inline 
function, same result.
There is probably different rip getting sampled or different sortkey 
used. The previous example is:
perf report --no-children --stdio --inline

If I use the perf report --children --stdio --inline, the result is

# Children      Self  Command  Shared Object        Symbol
# ........  ........  .......  ................... 
..................................
#
     98.15%    56.76%  inline   inline               [.] main
             |
             |--56.76%--_start
             |          __libc_start_main
             |          main
             |
                        |
                        ---/usr/include/c++/5/bits/random.h:151 (inline)
                           /usr/include/c++/5/bits/random.h:332 (inline)
                           /usr/include/c++/5/bits/random.tcc:3328 (inline)
                           /usr/include/c++/5/bits/random.h:185 (inline)
                           /usr/include/c++/5/bits/random.h:1818 (inline)
                           /usr/include/c++/5/bits/random.h:1809 (inline)
/home/jinyao/skl-ws/perf-dev/lck-2867/test/inline.cpp:14 (inline)
              --41.39%--main
                        __hypot
                        |
                         --40.09%--__hypot_finite

Anyway, you can try my latest patch series and check what happens on 
your machine.
>>       40.54%  inline   libm-2.23.so         [.] __hypot_finite
>>
>>               ---__hypot_finite
>>
>>                   --40.09%--__hypot
>>
>>                             ---/usr/include/c++/5/bits/random.h:151 (inline)
>>                                /usr/include/c++/5/bits/random.h:332 (inline)
>> /usr/include/c++/5/bits/random.tcc:3328 (inline)
>>                                /usr/include/c++/5/bits/random.h:185 (inline)
>>                                /usr/include/c++/5/bits/random.h:1818 (inline)
>> /usr/include/c++/5/bits/random.h:1809 (inline)
>> /home/jinyao/skl-ws/perf-dev/lck-2867/test/inline.cpp:14 (inline)
>>                             main
>>                             __libc_start_main
>>                             _start
> Much better, great work! But again I have to ask the same question:
>
> Why not integrate directly with the other call stack nodes? This would solve
> the following problems:
>
> - correct display of children cost for inlined frames, i.e. in a `perf report
> --children --inline`, I suspect your branch won't actually show any top-level
> entries for inline.cpp:14, correct?
>
> - display/aggregation: currently you are always displaying srcline in your
> approach, what if I want to display/aggregate by function symbol instead?
I just follow the behavior of addr2line. If I use the command line 
"addr2line -e <binary> -i <rip>", it just display the srcline on my 
machine.
> So, could we please discuss this please?
>
> Thanks a lot
>
>> On 1/9/2017 4:41 PM, Milian Wolff wrote:
>>> On Monday, January 9, 2017 4:17:48 PM CET Jin, Yao wrote:
>>>> Hi Wolff,
>>>>
>>>> Thanks a lot for your test code!
>>>>
>>>> I have updated my patch. The new output for your test code (binary name
>>>> is inline) is:
>>>>
>>>> # Overhead  Command  Shared Object        Symbol
>>>> # ........  .......  ...................
>>>> ..................................
>>>> #
>>>>
>>>>        56.76%  inline   inline               [.] main
>>>>        
>>>>                ---main
>>>>                
>>>>                   __libc_start_main
>>>>                   _start
>>>>        
>>>>        40.54%  inline   libm-2.23.so         [.] __hypot_finite
>>>>        
>>>>                ---__hypot_finite
>>>>                
>>>>                    --40.09%--__hypot
>>>>                    
>>>>                              main
>>>>                              __libc_start_main
>>>>                              _start
>>>>         
>>>>         1.30%  inline   libm-2.23.so         [.] __hypot
>>>>         
>>>>                ---__hypot
>>>>                
>>>>                   main
>>>>                   
>>>>                   ---/usr/include/c++/5/bits/random.h:151 (inline)
>>>>                   
>>>>                      /usr/include/c++/5/bits/random.h:332 (inline)
>>>>                      /usr/include/c++/5/bits/random.tcc:3328 (inline)
>>>>                      /usr/include/c++/5/bits/random.h:185 (inline)
>>>>                      /usr/include/c++/5/bits/random.h:1818 (inline)
>>>>                      /usr/include/c++/5/bits/random.h:1809 (inline)
>>>>
>>>> /home/jinyao/skl-ws/perf-dev/lck-2867/test/inline.cpp:14 (inline)
>>>>
>>>>                   __libc_start_main
>>>>                   _start
>>>>
>>>> The inline entry is tagged with "(inline)". Is this result within
>>>> expectation?
>>> No, this is not the expected output. I expect to get information about the
>>> inlined frames in the middle of the call stack, in this example that
>>> happens for the first two major hotspots.
>>>
>>> Below is the output from my approach to this problem using my -g srcline:
>>>
>>> ~~~~~~~~~~~~~~ pasted here for readability:
>>> https://paste.kde.org/pmq3bc1le
>>> Samples: 149  of event 'cycles:ppp', Event count (approx.): 141334499
>>>
>>>     Overhead  Command  Shared Object     Symbol
>>>
>>> -   62.24%  inline   inline            [.] main
>>>
>>>      - 27.98% std::generate_canonical<double, 53ul,
>>>
>>> std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>
>>>> random.tcc:3332
>>>           std::__detail::_Adaptor<std::linear_congruential_engine<unsigned
>>>           long,
>>>
>>> 16807ul, 0ul, 2147483647ul>, double>::operator() random.h:185
>>>
>>>           std::uniform_real_distribution<double>::operator()<std::linear_co
>>>           ngruential_engine<unsigned>
>>> long, 16807ul, 0ul, 2147483647ul> > random.h:1818
>>>
>>>           std::uniform_real_distribution<double>::operator()<std::linear_co
>>>           ngruential_engine<unsigned>
>>> long, 16807ul, 0ul, 2147483647ul> > random.h:1809
>>>
>>>           main ine.cpp:14
>>>           __libc_start_main +241
>>>           _start +4194346
>>>      
>>>      - 25.88% std::__detail::_Mod<unsigned long, 2147483647ul, 16807ul,
>>>      0ul,
>>>
>>> true, true>::__calc random.h:143
>>>
>>>           std::__detail::__mod<unsigned long, 2147483647ul, 16807ul, 0ul>
>>>
>>> random.h:151
>>>
>>>           std::linear_congruential_engine<unsigned long, 16807ul, 0ul,
>>>
>>> 2147483647ul>::operator() random.h:332
>>>
>>>           std::generate_canonical<double, 53ul,
>>>
>>> std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>
>>>> random.tcc:3332
>>>           std::__detail::_Adaptor<std::linear_congruential_engine<unsigned
>>>           long,
>>>
>>> 16807ul, 0ul, 2147483647ul>, double>::operator() random.h:185
>>>
>>>           std::uniform_real_distribution<double>::operator()<std::linear_co
>>>           ngruential_engine<unsigned>
>>> long, 16807ul, 0ul, 2147483647ul> > random.h:1818
>>>
>>>           std::uniform_real_distribution<double>::operator()<std::linear_co
>>>           ngruential_engine<unsigned>
>>> long, 16807ul, 0ul, 2147483647ul> > random.h:1809
>>>
>>>           main ine.cpp:14
>>>           __libc_start_main +241
>>>           _start +4194346
>>>      
>>>      + 4.14% main inline.cpp:13
>>>      + 2.89%
>>>
>>> std::uniform_real_distribution<double>::operator()<std::linear_congruentia
>>> l_engine<unsigned long, 16807ul, 0ul, 2147483647ul> > random.h:1818
>>>
>>>      + 0.68% std::_Norm_helper<true>::_S_do_it<double> complex:655
>>>      + 0.67% std::generate_canonical<double, 53ul,
>>>
>>> std::linear_congruential_engine<unsigned long, 16807ul, 0ul, 2147483647ul>
>>>> random.tcc:3326
>>> -   26.24%  inline   libm-2.24.so      [.] __hypot_finite
>>>
>>>      - __hypot_finite +179
>>>      
>>>         - 25.56% hypot +20
>>>         
>>>              std::__complex_abs complex:589
>>>              std::abs<double> complex:597
>>>              std::_Norm_helper<true>::_S_do_it<double> complex:654
>>>              std::norm<double> complex:664
>>>              main ine.cpp:14
>>>              __libc_start_main +241
>>>              _start +4194346
>>>           
>>>           0.68% 0x40ead238ed1a2cf4
>>>
>>> -    6.85%  inline   libm-2.24.so      [.] hypot
>>>
>>>        hypot +40
>>>        std::__complex_abs complex:589
>>>        std::abs<double> complex:597
>>>        std::_Norm_helper<true>::_S_do_it<double> complex:654
>>>        std::norm<double> complex:664
>>>        main ine.cpp:14
>>>        __libc_start_main +241
>>>        _start +4194346
>>>
>>> ~~~~~~~~~~~~~~
>>>
>>> I hope you see the value of such a report versus what you are proposing.
>>>
>>> Thanks
>
