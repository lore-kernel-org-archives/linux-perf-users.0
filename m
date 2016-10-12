From: William Cohen <wcohen@redhat.com>
Subject: Re: [PATCH] s390: Add support for z13
Date: Wed, 12 Oct 2016 16:27:46 -0400
Message-ID: <44aa1856-f35d-4077-df94-c588d5b3b1e2@redhat.com>
References: <m3mvnwu1cy.fsf@oc1027705133.ibm.com>
	<bb9acd86-0c7c-7291-00c1-1c6ad8576232@redhat.com>
	<m360p8m87d.fsf@oc1027705133.ibm.com>
	<d2177055-a1c3-7562-f555-bd239836af3e@redhat.com>
	<alpine.LRH.2.20.1610042254100.6819@Diego>
	<m3vax6lkon.fsf@oc1027705133.ibm.com>
	<alpine.LRH.2.20.1610121546540.14258@Diego>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
In-Reply-To: <alpine.LRH.2.20.1610121546540.14258@Diego>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: Michael Petlan <mpetlan@redhat.com>, Andreas Arnez <arnez@linux.vnet.ibm.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, oprofile-list@lists.sf.net
List-Id: linux-perf-users.vger.kernel.org

On 10/12/2016 10:01 AM, Michael Petlan wrote:
> On Wed, 5 Oct 2016, Andreas Arnez wrote:
>> On Tue, Oct 04 2016, Michael Petlan wrote:
>>
>>> Hi Andreas,
>>>
>>> have you or anyone tested this patch and/or s390 oprofile support
>>> in general? I'd love to know more about the results or at least,
>>> if there any, what has been tested and what not + whether there
>>> are any known issues regarding to HW sampling on s390.
>>
>> IIRC, I just performed a quick smoke test before submitting this patch;
>> and oprofile didn't crash.  Other than that, I don't really know what
>> works and what doesn't.
>>

Hi Andreas and Andreas,

Is there support for IBM z13 perf counters in the upstream linux kernel?  I didn't see perf support for IBM z13 in the mainline kernel git repository.

There is a difference between the kernel and oprofile is the s390 identification.  The kernel is using hex numbers such as 0x2817 and 0x2818 for Z196 identification (http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/s390/kernel/perf_cpum_cf_events.c#n303), but oprofile is reading the numbers as decimal for idenfication (https://sourceforge.net/p/oprofile/oprofile/ci/master/tree/libop/op_cpu_type.c).  oprofile should also be using hex numbers like the kernel.

-Will
> 
> Could you please try it with setting /proc/sys/kernel/kptr_restrict to '0'
> and /proc/sys/kernel/perf_event_paranoid to '-1', being logged as root user?
> 
> `ophelp -r`
>   --> should detect the machine, print "IBM z13"
> 
> `ophelp -d`
>   --> should print default event "CPU_CYCLES"
> 
> `ocount ls`
>   --> should return some non-zero value for event CPU_CYCLES
> 
> `ocount -e INSTRUCTIONS ls`
>   --> should use INSTRUCTIONS and return a non-zero value too
> 
> Please try out also the --system-wide mode as root.
> 
> If the above commands work, at least the basic z13 support can be verified.
> 
>> Some people mentioned various issues with oprofile on s390, depending on
>> kernel version and environment.  Since I'm currently more focused on
>> other projects, I haven't investigated them.  Here are some
>> (unconfirmed) examples:
>>
>> * The --help/--usage options of operf and ocount behave strangely.
>>  E.g., they attempt perf_open and just emit a cryptic error message if
>>  that fails.  And upon success they still yield exit code 1.
> 
> Maybe if /proc/sys/kernel/perf_event_paranoid is '2' and the user is not
> root, this might happen.
> 
>>
>> * operf is showing a warning message:
>>
>>    Kernel profiling is not possible with current system config.
>>    Set /proc/sys/kernel/kptr_restrict to 0 to collect kernel samples.
>>
> Is kptr_restrict set to '0'?
> 
>> * Without the --system-wide option, operf generates all-zero statistics.
> 
> Does `ocount` do the same? If yes, the event counting probably does not
> work as expected.
> 
> 
> Thanks!
> Michael
> 
>>
>> -- 
>> Andreas
>>
>>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
