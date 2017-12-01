From: zhangmengting <zhangmengting@huawei.com>
Subject: Question to perf spending a large amount of time monitoring a java
 process
Date: Fri, 1 Dec 2017 15:32:06 +0800
Message-ID: <20d3fa12-295c-84d3-2eae-aa32b5757d19@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
        boundary="------------CE7E53DC475E354AE6753E34"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:11462 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdLAHcv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 1 Dec 2017 02:32:51 -0500
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: acme@redhat.com, namhyung@kernel.org, jolsa@redhat.com, huawei.libin@huawei.com, cj.chengjian@huawei.com, zhangmengting@huawei.com

--------------CE7E53DC475E354AE6753E34
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

I found that perf spends a large amount of time attaching and monitoring
a java process with lock, although the execution time of the java process
is below 1 minute.

Attachment 1(ContextSwitchTest.java) is the java source code used to
reproduce the problem. The code is compiled and run with the following
commands. The arguments of the process are <number of RUNS>
(how many times the test code will be excuated) and <lock ITERATES>
(how many times the thread acquires lock).
With arguments <1, 1000000>, the execution time of the process is just 
one minute.

$javac ContextSwitchTest.java

$java ContextSwitchTest
Usage:
java -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints 
ContextSwitchTest  <number of RUNS>  <lock ITERATES>
Example:
java -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints 
ContextSwitchTest 1 1000000

I've tested the problem on both x86 and ARM64 platform with 4.14 kernel 
and 4.14 perf.
And for convenience, I've add time check code to detect the execution 
time for perf record.
Attachment 2 is the time check patch 
(0001-perf-record-add-execution-time-check-code.patch)

The test result is shown below:
1) On x86 platform
a. The execution time of this java process
$java -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints 
ContextSwitchTest 1 1000000
RUNS : 1, ITERATES : 1000000
Name : Thread-0, 21
Name : Thread-1, 22
parks: 979010
parks: 978929
Average time: 28642ns
Total time: 56081313428ns = 56s
b. The execution time of perf monitoring this process with several event 
groups
$perf record -N -B -T -g -e 
'{cycles,r008,r01b,r10c,r009},{cycles,r100,r102,r107,r108},\
{cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108},\
{cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108},\
{cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108},\
{cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108},{cycles,r100,r102,r107,r108}'\
java -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints 
ContextSwitchTest 1 1000000
record_open_RUN is 0.235386s
RUNS : 1, ITERATES : 1000000
Name : Thread-0, 21
Name : Thread-1, 22
parks: 997895
parks: 998116
Average time: 72197ns
Total time: 144107437593ns = 144s
pollfd_RUN is 169.4294951967s
[ perf record: Woken up 148 times to write data ]
[ perf record: Captured and wrote 0.060 MB perf.data ]
Record_RUN is 170.4294783665s

2) On ARM64 platform
a. The execution time of this java process
$java -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints 
ContextSwitchTest 1 1000000
RUNS : 1, ITERATES : 1000000
Name : Thread-0, 24
Name : Thread-1, 25
parks: 977285
parks: 977279
Average time: 4708ns
Total time: 9203640720ns = 9s
b. The execution time of perf monitoring this process with several event 
groups
$perf record -N -B -T -g -e'{cycles,r008,r01b,r10c,r009,r010,r012},\
{cycles,r100,r102,r107,r108,r076,r078},{cycles,r001,r002,r014,r179,r177},\
{cycles,r121,r122,r123,r124,r125,r126},{cycles,r040,r042,r050,r052,r060,r061},\
{cycles,r003,r004,r005,r016,r017},{cycles,r070,r071,r073,r074,r075,r077},\
{cycles,r112,r113,r12c,r111,r120},{cycles,r06c,r06d,r06e,r07c,r07d,r07e},\
{cycles,r150,r151,r152,r16a,r079,r07a}' \
java -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints 
ContextSwitchTest 1 1000000
record_open_RUN is 0.40954s
RUNS : 1, ITERATES : 1000000
Name : Thread-0, 24
Name : Thread-1, 25
parks: 1008468
parks: 1003826
Average time: 1154505ns
Total time: 2323208237220ns = 2323s
pollfd_RUN is 2326.645806s
[ perf record: Woken up 18463 times to write data ]
[ perf record: Captured and wrote 6263.982 MB perf.data ]
Record_RUN is 2328.4294867157s

The test result shows that perf consumes most of the time polling fds.
In addtion, it seems that when tracing a great amount of events, perf may
extend the execution time of the traced process, especially on ARM64 
platform.
A process that runs only 10 seconds now needs an hour execution time, 
which is
somewhat insane.

I confuses that how perf affects the traced process and whether the
final perf.data is still accurate since perf has affected the traced 
process?
Is there something wrong with perf?

Thanks,
Mengting Zhang


--------------CE7E53DC475E354AE6753E34
Content-Type: text/java; name="ContextSwitchTest.java"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="ContextSwitchTest.java"

import java.util.concurrent.atomic.AtomicReference;
import java.util.concurrent.locks.LockSupport;    

public final class ContextSwitchTest {
    static int RUNS = 1;
    static int ITERATES = 1000;
    static AtomicReference turn = new AtomicReference();

    static final class WorkerThread extends Thread {
        volatile Thread other;
        volatile int nparks;
        public void run() {
            final AtomicReference t = turn;
            final Thread other = this.other;
            
	    Thread current = Thread.currentThread();  
            System.out.println("Name : " + current.getName() +", " + current.getId( ));

            if (turn == null || other == null)
                throw new NullPointerException();
            int p = 0;
            for (int i = 0; i < ITERATES; ++i) {
                while (!t.compareAndSet(other, this)) {
                    LockSupport.park();
                    ++p;
                }
                LockSupport.unpark(other);
            }
            LockSupport.unpark(other);
            nparks = p;
            System.out.println("parks: " + p);

        }
    }

    static void test() throws Exception {
        WorkerThread a = new WorkerThread();
        WorkerThread b = new WorkerThread();
        a.other = b;
        b.other = a;
        turn.set(a);
        long startTime = System.nanoTime();
        a.start();
        b.start();
        a.join();
        b.join();
        long endTime = System.nanoTime();
        int parkNum = a.nparks + b.nparks;
        System.out.println("Average time: " + ((endTime - startTime) / parkNum)
                           + "ns");
    }

    public static void main(String[] args) throws Exception {
	if (args.length != 2) {
                System.out.println("Usage: \n" +
                                   "java -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints  ContextSwitchTest  <number of RUNS>  <lock ITERATES>");
                System.out.println("Example: \n" +
                                   "java -XX:+UnlockDiagnosticVMOptions -XX:+DebugNonSafepoints  ContextSwitchTest 1 1000000");
                System.exit(0);
        }
        if (args.length == 2) {
		RUNS = Integer.parseInt(args[0]);
    		ITERATES = Integer.parseInt(args[1]);
	}

        System.out.println("RUNS : " + RUNS + ", ITERATES : " + ITERATES);
	long startTime = System.nanoTime();
        for (int i = 0; i < RUNS; i++) {
            test();
        }
        long endTime = System.nanoTime();
        System.out.println("Total time: " + ((endTime - startTime)) + "ns = " + (endTime - startTime) / 1000000000 + "s");
    }
}

--------------CE7E53DC475E354AE6753E34
Content-Type: text/plain; charset="UTF-8";
	name="0001-perf-record-add-execution-time-check-code.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="0001-perf-record-add-execution-time-check-code.patch"

RnJvbSBmMjFkOGIyZjczMjk3ODVkYTI3NTQ4ZTYxMTUyZDdjZDU0MmQ5ZWUxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNZW5ndGluZyBaaGFuZyA8emhhbmdtZW5ndGluZ0Bo
dWF3ZWkuY29tPgpEYXRlOiBGcmksIDEgRGVjIDIwMTcgMTM6NDM6NTcgKzA4MDAKU3ViamVj
dDogW1BBVENIXSBwZXJmIHJlY29yZDogYWRkIGV4ZWN1dGlvbiB0aW1lIGNoZWNrIGNvZGUK
CiJyZWNvcmRfb3Blbl9SVU4iIG1lYW5zIHRoZSB0aW1lIG9mIHJlY29yZF9fb3BlbigpOwoi
UmVjb3JkX1JVTiIgbWVhbnMgdGhlIHRpbWUgb2YgY21kX3JlY29yZCgpOwoicG9sbGZkX1JV
TiIgbWVhbnMgdGhlIHRpbWUgb2YgbWFpbiBwYXJ0IG9mIF9fY21kX3JlY29yZCgpCnBvbGxp
bmcgZmRzOwoKVGVzdCBpdDoKJHBlcmYgcmVjb3JkIHNsZWVwIDEKJHJlY29yZF9vcGVuX1JV
TiBpcyAxLjQyOTQwNDczNTFzCnBvbGxmZF9SVU4gaXMgMS44NjE3cwpbIHBlcmYgcmVjb3Jk
OiBXb2tlbiB1cCAxIHRpbWVzIHRvIHdyaXRlIGRhdGEgXQpbIHBlcmYgcmVjb3JkOiBDYXB0
dXJlZCBhbmQgd3JvdGUgMC4wMTQgTUIgcGVyZi5kYXRhICgyOCBzYW1wbGVzKSBdClJlY29y
ZF9SVU4gaXMgMi40Mjk0NjI4NjkwcwoKU2lnbmVkLW9mZi1ieTogTWVuZ3RpbmcgWmhhbmcg
PHpoYW5nbWVuZ3RpbmdAaHVhd2VpLmNvbT4KLS0tCiB0b29scy9wZXJmL2J1aWx0aW4tcmVj
b3JkLmMgfCAyMiArKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMjIg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL3BlcmYvYnVpbHRpbi1yZWNvcmQu
YyBiL3Rvb2xzL3BlcmYvYnVpbHRpbi1yZWNvcmQuYwppbmRleCA1NmY4MTQyLi5mMGYwZGFi
IDEwMDY0NAotLS0gYS90b29scy9wZXJmL2J1aWx0aW4tcmVjb3JkLmMKKysrIGIvdG9vbHMv
cGVyZi9idWlsdGluLXJlY29yZC5jCkBAIC01MCw2ICs1MCw3IEBACiAjaW5jbHVkZSA8c2ln
bmFsLmg+CiAjaW5jbHVkZSA8c3lzL21tYW4uaD4KICNpbmNsdWRlIDxzeXMvd2FpdC5oPgor
I2luY2x1ZGUgPHN5cy90aW1lLmg+CiAjaW5jbHVkZSA8YXNtL2J1Zy5oPgogI2luY2x1ZGUg
PGxpbnV4L3RpbWU2NC5oPgogCkBAIC00MzIsNiArNDMzLDggQEAgc3RhdGljIGludCByZWNv
cmRfX29wZW4oc3RydWN0IHJlY29yZCAqcmVjKQogCXN0cnVjdCByZWNvcmRfb3B0cyAqb3B0
cyA9ICZyZWMtPm9wdHM7CiAJc3RydWN0IHBlcmZfZXZzZWxfY29uZmlnX3Rlcm0gKmVycl90
ZXJtOwogCWludCByYyA9IDA7CisJc3RydWN0IHRpbWV2YWwgc3RhcnQsIGVuZDsKKwlnZXR0
aW1lb2ZkYXkoJnN0YXJ0LCBOVUxMKTsKIAogCXBlcmZfZXZsaXN0X19jb25maWcoZXZsaXN0
LCBvcHRzLCAmY2FsbGNoYWluX3BhcmFtKTsKIApAQCAtNDc1LDYgKzQ3OCwxMCBAQCBzdGF0
aWMgaW50IHJlY29yZF9fb3BlbihzdHJ1Y3QgcmVjb3JkICpyZWMpCiAJc2Vzc2lvbi0+ZXZs
aXN0ID0gZXZsaXN0OwogCXBlcmZfc2Vzc2lvbl9fc2V0X2lkX2hkcl9zaXplKHNlc3Npb24p
Owogb3V0OgorCWdldHRpbWVvZmRheSgmZW5kLCBOVUxMKTsKKwlwcmludGYoInJlY29yZF9v
cGVuX1JVTiBpcyAldS4ldXNcbiIsCisJCSh1bnNpZ25lZCBpbnQpKGVuZC50dl9zZWMgLSBz
dGFydC50dl9zZWMpLAorCQkodW5zaWduZWQgaW50KShlbmQudHZfdXNlYyAtIHN0YXJ0LnR2
X3VzZWMpKTsKIAlyZXR1cm4gcmM7CiB9CiAKQEAgLTg4MSw2ICs4ODgsNyBAQCBzdGF0aWMg
aW50IF9fY21kX3JlY29yZChzdHJ1Y3QgcmVjb3JkICpyZWMsIGludCBhcmdjLCBjb25zdCBj
aGFyICoqYXJndikKIAlzdHJ1Y3QgcGVyZl9zZXNzaW9uICpzZXNzaW9uOwogCWJvb2wgZGlz
YWJsZWQgPSBmYWxzZSwgZHJhaW5pbmcgPSBmYWxzZTsKIAlpbnQgZmQ7CisJc3RydWN0IHRp
bWV2YWwgc3RhcnQsIGVuZDsKIAogCXJlYy0+cHJvZ25hbWUgPSBhcmd2WzBdOwogCkBAIC0x
MDUxLDYgKzEwNTksNyBAQCBzdGF0aWMgaW50IF9fY21kX3JlY29yZChzdHJ1Y3QgcmVjb3Jk
ICpyZWMsIGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndikKIAl0cmlnZ2VyX3JlYWR5KCZh
dXh0cmFjZV9zbmFwc2hvdF90cmlnZ2VyKTsKIAl0cmlnZ2VyX3JlYWR5KCZzd2l0Y2hfb3V0
cHV0X3RyaWdnZXIpOwogCXBlcmZfaG9va3NfX2ludm9rZV9yZWNvcmRfc3RhcnQoKTsKKwln
ZXR0aW1lb2ZkYXkoJnN0YXJ0LCBOVUxMKTsKIAlmb3IgKDs7KSB7CiAJCXVuc2lnbmVkIGxv
bmcgbG9uZyBoaXRzID0gcmVjLT5zYW1wbGVzOwogCkBAIC0xMTQ4LDYgKzExNTcsMTEgQEAg
c3RhdGljIGludCBfX2NtZF9yZWNvcmQoc3RydWN0IHJlY29yZCAqcmVjLCBpbnQgYXJnYywg
Y29uc3QgY2hhciAqKmFyZ3YpCiAJCQlkaXNhYmxlZCA9IHRydWU7CiAJCX0KIAl9CisJZ2V0
dGltZW9mZGF5KCZlbmQsIE5VTEwpOworCXByaW50ZigicG9sbGZkX1JVTiBpcyAldS4ldXNc
biIsCisJCSh1bnNpZ25lZCBpbnQpKGVuZC50dl9zZWMgLSBzdGFydC50dl9zZWMpLAorCQko
dW5zaWduZWQgaW50KShlbmQudHZfdXNlYyAtIHN0YXJ0LnR2X3VzZWMpKTsKKwogCXRyaWdn
ZXJfb2ZmKCZhdXh0cmFjZV9zbmFwc2hvdF90cmlnZ2VyKTsKIAl0cmlnZ2VyX29mZigmc3dp
dGNoX291dHB1dF90cmlnZ2VyKTsKIApAQCAtMTY4OCw2ICsxNzAyLDggQEAgaW50IGNtZF9y
ZWNvcmQoaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2KQogCWludCBlcnI7CiAJc3RydWN0
IHJlY29yZCAqcmVjID0gJnJlY29yZDsKIAljaGFyIGVycmJ1ZltCVUZTSVpdOworCXN0cnVj
dCB0aW1ldmFsIHN0YXJ0LCBlbmQ7CisJZ2V0dGltZW9mZGF5KCZzdGFydCwgTlVMTCk7CQog
CiAjaWZuZGVmIEhBVkVfTElCQlBGX1NVUFBPUlQKICMgZGVmaW5lIHNldF9ub2J1aWxkKHMs
IGwsIGMpIHNldF9vcHRpb25fbm9idWlsZChyZWNvcmRfb3B0aW9ucywgcywgbCwgIk5PX0xJ
QkJQRj0xIiwgYykKQEAgLTE4ODQsNiArMTkwMCwxMiBAQCBpbnQgY21kX3JlY29yZChpbnQg
YXJnYywgY29uc3QgY2hhciAqKmFyZ3YpCiAJcGVyZl9ldmxpc3RfX2RlbGV0ZShyZWMtPmV2
bGlzdCk7CiAJc3ltYm9sX19leGl0KCk7CiAJYXV4dHJhY2VfcmVjb3JkX19mcmVlKHJlYy0+
aXRyKTsKKworCWdldHRpbWVvZmRheSgmZW5kLCBOVUxMKTsKKwlwcmludGYoIlJlY29yZF9S
VU4gaXMgJXUuJXVzXG4iLAorCQkodW5zaWduZWQgaW50KShlbmQudHZfc2VjIC0gc3RhcnQu
dHZfc2VjKSwKKwkJKHVuc2lnbmVkIGludCkoZW5kLnR2X3VzZWMgLSBzdGFydC50dl91c2Vj
KSk7CisKIAlyZXR1cm4gZXJyOwogfQogCi0tIAoxLjcuMTIuNAoK
--------------CE7E53DC475E354AE6753E34--
