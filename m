From: William Cohen <wcohen@redhat.com>
Subject: Re: [PATCH] s390: Add support for z13
Date: Thu, 13 Oct 2016 10:15:05 -0400
Message-ID: <1cb7be99-0b62-3dab-1194-20fe3171ac44@redhat.com>
References: <m3mvnwu1cy.fsf@oc1027705133.ibm.com>
	<bb9acd86-0c7c-7291-00c1-1c6ad8576232@redhat.com>
	<m360p8m87d.fsf@oc1027705133.ibm.com>
	<d2177055-a1c3-7562-f555-bd239836af3e@redhat.com>
	<alpine.LRH.2.20.1610042254100.6819@Diego>
	<m3vax6lkon.fsf@oc1027705133.ibm.com>
	<alpine.LRH.2.20.1610121546540.14258@Diego>
	<44aa1856-f35d-4077-df94-c588d5b3b1e2@redhat.com>
	<alpine.LRH.2.20.1610131424000.14258@Diego>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------BEB74444D5076830CF39B013"
Return-path: <oprofile-list-bounces@lists.sourceforge.net>
In-Reply-To: <alpine.LRH.2.20.1610131424000.14258@Diego>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=oprofile-list>
List-Post: <mailto:oprofile-list@lists.sourceforge.net>
List-Help: <mailto:oprofile-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/oprofile-list>,
	<mailto:oprofile-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: oprofile-list-bounces@lists.sourceforge.net
To: Michael Petlan <mpetlan@redhat.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Andreas Krebbel <krebbel@linux.vnet.ibm.com>, oprofile-list@lists.sf.net, Andreas Arnez <arnez@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

This is a multi-part message in MIME format.
--------------BEB74444D5076830CF39B013
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 10/13/2016 08:42 AM, Michael Petlan wrote:
> On Wed, 12 Oct 2016, William Cohen wrote:
>> On 10/12/2016 10:01 AM, Michael Petlan wrote:
>>> On Wed, 5 Oct 2016, Andreas Arnez wrote:
>>>>
>>>> IIRC, I just performed a quick smoke test before submitting this patch;
>>>> and oprofile didn't crash.  Other than that, I don't really know what
>>>> works and what doesn't.
>>>>
>>
>> Hi Andreas and Andreas,
>>
>> Is there support for IBM z13 perf counters in the upstream linux kernel?  I didn't see perf support for IBM z13 in the mainline kernel git repository.
>>
>> There is a difference between the kernel and oprofile is the s390 identification.  The kernel is using hex numbers such as 0x2817 and 0x2818 for Z196 identification (http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/s390/kernel/perf_cpum_cf_events.c#n303), but oprofile is reading the numbers as decimal for idenfication (https://sourceforge.net/p/oprofile/oprofile/ci/master/tree/libop/op_cpu_type.c).  oprofile should also be using hex numbers like the kernel.
> 
> I have looked at this and although it is not ideal, it works OK in OProfile,
> since it reads the numbers from string, thus it works with decimals.
> 
> I have also checked that zEC12 detection works correctly with 1.1.
> 
> Michael

Yes, the s390 processor detection in oprofile is not ideal with the kernel outputting the id in hex and the oprofile reading it in as a decimal.  Good thing that none of the s390 id values have a-f in the digits.  Attached is a patch that reads in the values as hex to better line up with the kernel's handling of the s390 identification.  Could one of the IBM people try this patch?

-Will


--------------BEB74444D5076830CF39B013
Content-Type: text/x-patch;
 name="oprofile-s390-hexid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="oprofile-s390-hexid.patch"

diff --git a/libop/op_cpu_type.c b/libop/op_cpu_type.c
index e70e4f6..ea5ff76 100644
--- a/libop/op_cpu_type.c
+++ b/libop/op_cpu_type.c
@@ -668,20 +668,19 @@ static op_cpu _get_s390_cpu_type(void)
 		return CPU_NO_GOOD;
 
 	ptr += sizeof(prefix) - 1;
-	if (sscanf(ptr, "%u", &model) != 1)
-		return CPU_NO_GOOD;
+	model = strtol(ptr, NULL, 16);
 
 	switch (model) {
-	case 2097:
-	case 2098:
+	case 0x2097:
+	case 0x2098:
 		return CPU_S390_Z10;
-	case 2817:
-	case 2818:
+	case 0x2817:
+	case 0x2818:
 		return CPU_S390_Z196;
-	case 2827:
-	case 2828:
+	case 0x2827:
+	case 0x2828:
 		return CPU_S390_ZEC12;
-	case 2964:
+	case 0x2964:
 		return CPU_S390_Z13;
 	}
 	return CPU_NO_GOOD;

--------------BEB74444D5076830CF39B013
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
--------------BEB74444D5076830CF39B013
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
oprofile-list mailing list
oprofile-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/oprofile-list

--------------BEB74444D5076830CF39B013--
